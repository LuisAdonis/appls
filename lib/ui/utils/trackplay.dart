import 'package:appls/models/chapter_model.dart';
import 'package:appls/models/libro_model.dart';
import 'package:appls/models/models/Album.dart';
import 'package:appls/models/models/Track.dart';
import 'package:appls/service/playerprovider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackPlayButton extends StatelessWidget {
  final Chapter? track;
  final int index;
  final Function? onPressed;
  final LibroModel? cai;

  TrackPlayButton({
    this.track,
    required this.index,
    this.onPressed,
    this.cai,
  });

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<PlayerProvider>(context, listen: false);
    return PlayerBuilder.isPlaying(
        player: p.player,
        builder: (context, isPlaying) {
          return SizedBox(
            height: 40,
            width: 40,
            child: !p.isTrackLoaded && p.tIndex == index
                ? const Padding(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    padding: EdgeInsets.all(10))
                : IconButton(
                    color: Colors.black,
                    icon: p.isTrackInProgress(track!)
                        ? const Icon(
                            Icons.pause,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                    onPressed: () {
                      p.setBuffering(index);
                      p.currentATrac(track!, cai);
                      p.handlePlayButton(
                        track: track!,
                        index: index,
                        //search results list
                      );
                    }),
          );
        });
  }
}
