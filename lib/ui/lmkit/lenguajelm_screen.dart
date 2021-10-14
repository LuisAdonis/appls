import 'package:appls/const.dart';
import 'package:appls/models/sceen_arg_model.dart';
import 'package:appls/ui/utils/hexcolor.dart';
import 'package:appls/ui/widget/realtime/bounding_box.dart';
import 'package:appls/ui/widget/realtime/camerafeed.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class LenguahelmScreen extends StatefulWidget {
  const LenguahelmScreen({Key? key}) : super(key: key);

  @override
  _LenguahelmScreenState createState() => _LenguahelmScreenState();
}

class _LenguahelmScreenState extends State<LenguahelmScreen> {
  List<CameraDescription> cameras = [];
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;

  var stado = true;

  List data = [];
  initCameras() async {}
  loadTfModel() async {
    cameras = await availableCameras();
    setState(() {});
    await Tflite.loadModel(
      model: "assets/tflite/detect.tflite",
      labels: "assets/tflite/labelmap.txt",
    );
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTfModel();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    if (_recognitions.isNotEmpty) {
      if (data.isNotEmpty) {
        if (data.last != _recognitions[0]['detectedClass']) {
          data.add("${_recognitions[0]['detectedClass']}");
        }
      } else {
        data.add("${_recognitions[0]['detectedClass']}");
      }
    }
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appname,
          textScaleFactor: 1.4,
        ),
        backgroundColor: HexColor(args.startColor),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                CameraFeed(cameras: cameras, setRecognitions: setRecognitions, isDetecting: stado),
                BoundingBox(
                  _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  width: screen.width,
                  height: 100,
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                stado
                                    ? setState(() {
                                        stado = false;
                                      })
                                    : setState(() {
                                        stado = true;
                                      });
                              },
                              child: Icon(stado ? Icons.play_arrow : Icons.pause),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  stado = true;
                                  data.clear();
                                });
                              },
                              child: Icon(Icons.refresh),
                            ),
                          ],
                        ),
                        Text(data.toString()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Expanded(
          //   flex: 2,
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Card(
          //       elevation: 10,
          //       child: Row(
          //         children: [
          //           TextButton(
          //             onPressed: () {},
          //             child: Icon(Icons.play_arrow),
          //           ),
          //           TextButton(
          //             onPressed: () {},
          //             child: Icon(Icons.refresh),
          //           )
          //           // TextButton(
          //           //   child: Text(!stado ? "Detectando" : "Iniciar"),
          //           //   onPressed: () {
          //           //     stado
          //           //         ? setState(() {
          //           //             stado = false;
          //           //           })
          //           //         : setState(() {
          //           //             stado = true;
          //           //           });
          //           //   },
          //           // ),
          //           // Text(data.toString()),
          //           // Text(
          //           //   "$_recognitions",
          //           //   textScaleFactor: 1.0,
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
