import 'package:appls/models/data_arguments_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ResultadosPage extends StatefulWidget {
  final DataArguments arguments;

  const ResultadosPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  String? src;

  late String img;

  late YoutubePlayerController _controller;

  // ignore: unused_field
  late PlayerState _playerState;
  // ignore: unused_field
  late YoutubeMetaData _videoMetaData;
  // ignore: unused_field
  final double _volume = 100;
  // ignore: unused_field
  final bool _muted = false;
  bool _isPlayerReady = false;
  String? videoId;
  @override
  void initState() {
    img = "http://via.placeholder.com/350x150";
    super.initState();
    makeRequest();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  makeRequest() async {
    Uri url = Uri.parse(widget.arguments.nodep);
    var response = await http.get(url);

    //If the http request is successful the statusCode will be 200
    if (response.statusCode == 200) {
      var document = parse(response.body);
      document.getElementsByTagName("iframe").forEach((e) async {
        src = e.attributes['src'];
        // print("datos:1 ${src}");
        final regex = RegExp(r'.*\/(.+?)\?.+', caseSensitive: false, multiLine: false);
        final url = [src];
        if (regex.hasMatch(src!)) {
          setState(() {
            videoId = regex.firstMatch(src!)!.group(1);
          });
          _controller = YoutubePlayerController(
            initialVideoId: videoId!,
            flags: const YoutubePlayerFlags(
              mute: false,
              hideControls: false,
              autoPlay: false,
              disableDragSeek: false,
              loop: true,
              isLive: false,
              forceHD: false,
              enableCaption: true,
            ),
          )..addListener(listener);
          // ignore: avoid_print
          print(videoId);
        } else {
          // ignore: avoid_print
          print("Cannot parse $url");
        }
      });
      document.getElementsByTagName("img").forEach((e) async {
        var dataaa = e.attributes['srcset']?.split(" ");
        if (dataaa?[0] != null) {
          setState(() {
            img = dataaa![0];
          });
        } else {
          img = "";
        }
      });
    } else {
      // ignore: avoid_print
      print("object");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          widget.arguments.ctg!.replaceAll("\n", ""),
          style: const TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       makeRequest();
        //     },
        //     icon: const Icon(Icons.save),
        //   )
        // ],
      ),
      body: src != null
          ? Column(
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                      topActions: <Widget>[
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            _controller.metadata.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          onPressed: () {
                            // ignore: avoid_print
                            print('Settings Tapped!');
                          },
                        ),
                      ],
                      onReady: () {
                        _isPlayerReady = true;
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 2,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    // ignore: prefer_const_constructors
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
