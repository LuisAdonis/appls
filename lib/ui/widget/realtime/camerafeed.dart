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
            Tflite.detectObjectOnFrame(
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
            ).then((recognitions) {
              /*
              When setRecognitions is called here, the parameters are being passed on to the parent widget as callback. i.e. to the LiveFeed class
               */
              widget.setRecognitions(recognitions!, img.height, img.width);
            });
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

    return OverflowBox(
      maxHeight: screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth: screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller!),
    );
  }
}
