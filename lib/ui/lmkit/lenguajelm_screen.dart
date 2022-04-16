import 'package:appls/const.dart';
import 'package:appls/models/sceen_arg_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
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
      numThreads: 1, // d
      //  model: "assets/tflite/mobilenet.tflite",
      // labels: "assets/tflite/labelss.txt",
      // numThreads: 4, // defaults to 1
      isAsset: true, // defaults to true, set to false to load resources outside assets
      useGpuDelegate: false,
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

  final presf = SPUsuarios();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
//  if (_recognitions.isNotEmpty) {
//                       if (data.isNotEmpty) {
//                         if (data.last != _recognitions[0]['detectedClass']) {
//                           data.add("${_recognitions[0]['detectedClass']}");
//                         }
//                       } else {
//                         data.add("${_recognitions[0]['detectedClass']}");
//                       }
//                     }
    if (stado) {
      AudioLS().speak(data.toString().replaceAll(",", "").replaceAll("[", "").replaceAll("]", "").replaceAll(" ", ""));
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
                GestureDetector(
                  onTap: () {
                    if (_recognitions.isNotEmpty) {
                      if (data.isNotEmpty) {
                        if (data.last != _recognitions[0]['detectedClass']) {
                          data.add("${_recognitions[0]['detectedClass']}");
                        }
                      } else {
                        data.add("${_recognitions[0]['detectedClass']}");
                      }
                    }
                  },
                  // child: Column(
                  //   children: [
                  //     _contentWidget(),
                  //   ],
                  // ),
                  child: false
                      ? _contentWidget()
                      : BoundingBox(
                          _recognitions,
                          math.max(_imageHeight, _imageWidth),
                          math.min(_imageHeight, _imageWidth),
                          screen.height,
                          screen.width,
                        ),
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
                              child: const Icon(Icons.refresh),
                            ),
                          ],
                        ),
                        Text(data.toString().replaceAll(",", "").replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "")),
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

  Widget _contentWidget() {
    var _width = MediaQuery.of(context).size.width;
    var _padding = 20.0;
    var _labelWitdth = 150.0;
    var _labelConfidence = 30.0;
    var _barWitdth = _width - _labelWitdth - _labelConfidence - _padding * 2.0;

    if (_recognitions.length > 0) {
      return Container(
        height: 150,
        child: ListView.builder(
          itemCount: _recognitions.length,
          itemBuilder: (context, index) {
            if (_recognitions.length > index) {
              print(_recognitions[index]['label']);
              return Container(
                height: 40,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: _padding, right: _padding),
                      width: _labelWitdth,
                      child: Text(
                        _recognitions[index]['label'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: _barWitdth,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        value: _recognitions[index]['confidence'],
                      ),
                    ),
                    Container(
                      width: _labelConfidence,
                      child: Text(
                        (_recognitions[index]['confidence'] * 100).toStringAsFixed(0) + '%',
                        maxLines: 1,
//                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      );
    } else {
      return Text('');
    }
  }
}
