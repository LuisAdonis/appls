import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tflite/tflite.dart';

typedef Callback = void Function(List<dynamic> list, int h, int w);

// ignore: must_be_immutable
class CameraFeed extends StatefulWidget {
  late List<CameraDescription> cameras;
  final Callback setRecognitions;
  late bool isDetecting;
  CameraFeed({Key? key, required this.cameras, required this.setRecognitions, required this.isDetecting}) : super(key: key);
  @override
  _CameraFeedState createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  CameraController? controller;

  bool aa = false;

  var zoom = 1.0;
  @override
  void initState() {
    super.initState();
    inises();
  }

  inises() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      // ignore: avoid_print
      print('No Cameras Found.');
    } else {
      // ignore: avoid_print
      print('bien.');

      controller = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
      );
      controller?.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller!.startImageStream((CameraImage img) {
          if (!widget.isDetecting) {
            widget.isDetecting = true;
            if (aa) {
              Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 2,
              ).then((recognitions) {
                int endTime = new DateTime.now().millisecondsSinceEpoch;
                print("Detection $recognitions");
                widget.setRecognitions(recognitions!, img.height, img.width);
              });
            } else {
              Tflite.detectObjectOnFrame(
                // Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),

                //model: "SSDMobileNet",
                imageHeight: img.height,
                imageWidth: img.width,
                imageMean: 127.5,
                imageStd: 127.5,
                numResultsPerClass: 1,
                threshold: 0.4,
                asynch: true,
                model: "SSDMobileNet",
                // numResults: 1,
              ).then((recognitions) {
                /*
              When setRecognitions is called here, the parameters are being passed on to the parent widget as callback. i.e. to the LiveFeed class
               */
                print(recognitions);
                widget.setRecognitions(recognitions!, img.height, img.width);
              });
            }
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller!.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return Container(
      height: screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      width: screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: Stack(
        children: [
          CameraPreview(controller!),
          Positioned(
            bottom: 100,
            left: 40,
            right: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Zoom: ${(zoom * 10).round()}"),
                  Slider(
                    activeColor: Colors.red,
                    value: zoom,
                    onChanged: (value) {
                      print(value);
                      value = value * 10;
                      if (value <= 8.0 && value >= 1.0) {
                        controller!.setZoomLevel(value);
                      }
                      setState(() => zoom = value / 10);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
