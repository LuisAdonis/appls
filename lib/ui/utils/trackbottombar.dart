import 'dart:math';

import 'package:appls/models/chapter_model.dart';
import 'package:appls/models/libro_model.dart';
import 'package:appls/service/playerprovider.dart';
import 'package:appls/ui/utils/trackplay.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackBottomBar extends StatefulWidget {
  const TrackBottomBar({Key? key}) : super(key: key);

  @override
  _TrackBottomBarState createState() => _TrackBottomBarState();
}

class _TrackBottomBarState extends State<TrackBottomBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlayerProvider playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    Chapter track;
    LibroModel capi;
    return PlayerBuilder.realtimePlayingInfos(
      player: playerProvider.player,
      builder: (context, infos) {
        track = playerProvider.currentTrack!;
        capi = playerProvider.capi1;
        // ignore: unnecessary_null_comparison
        if (track != null) {
          return GestureDetector(
            onTap: () {},
            child: Card(
              elevation: 10,
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  color: Colors.deepPurple,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                                animation: _controller,
                                builder: (_, child) {
                                  double _angle = _controller.value * 2 * pi;
                                  if (!playerProvider.isPlaying()) {
                                    _angle = 0.0;
                                  }

                                  return Transform.rotate(
                                    angle: _angle,
                                    // ignore: unnecessary_null_comparison
                                    child: playerProvider.player != null
                                        ? CachedNetworkImage(
                                            imageUrl: capi.imgUrl,
                                            width: 50,
                                          )
                                        : const Icon(
                                            Icons.disc_full,
                                            size: 30,
                                          ),
                                  );
                                }),
                            const SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Capítulo ${track.cap}", style: const TextStyle(fontSize: 16, color: Colors.white)),
                                Text(
                                  capi.autor,
                                  style: const TextStyle(fontSize: 12, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // ignore: unnecessary_null_comparison
                                if (infos != null)
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    child: LinearProgressIndicator(
                                      minHeight: 10,
                                      value: !playerProvider.isPlaying() ? 0.0 : infos.currentPosition.inMilliseconds / infos.duration.inMilliseconds,
                                      backgroundColor: Colors.deepPurple,
                                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // IconButton(
                                //   icon: Icon(Icons.refresh),
                                //   iconSize: 20,
                                //   color: playerProvider.isFirstTrack() ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColor,
                                //   onPressed: () {
                                //     playerProvider.prev();
                                //   },
                                // ),
                                TrackPlayButton(
                                  track: track,
                                  index: 0,
                                  cai: capi,
                                  onPressed: () {
                                    // ignore: avoid_print
                                    print("aaa");
                                    return playerProvider.playOrPause();
                                  },
                                ),
                                // IconButton(
                                //   icon: Icon(Icons.forward),
                                //   // color: playerProvider.isLastTrack(playerProvider.currentIndex + 1) ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColor,
                                //   iconSize: 20,
                                //   onPressed: () {
                                //     // if (playerProvider.isLastTrack(playerProvider.currentIndex + 1)) return;
                                //     // playerProvider.next();
                                //   },
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ], // ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
