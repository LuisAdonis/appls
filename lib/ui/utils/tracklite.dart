import 'package:appls/models/chapter_model.dart';
import 'package:appls/models/libro_model.dart';
import 'package:appls/service/playerprovider.dart';
import 'package:appls/ui/utils/trackplay.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackTile extends StatefulWidget {
  final Chapter? track;

  final int? index;
  final List<Chapter>? tracks;
  final LibroModel? capi;
  const TrackTile({
    Key? key,
    this.track,
    this.index,
    this.tracks,
    this.capi,
  }) : super(key: key);
  @override
  _TrackTileState createState() => _TrackTileState();
}

class _TrackTileState extends State<TrackTile> {
  @override
  Widget build(BuildContext context) {
    PlayerProvider p = Provider.of<PlayerProvider>(context);

    return PlayerBuilder.isPlaying(
      player: p.player,
      builder: (BuildContext context, bool isPlaying) {
        return Column(children: [
          Card(
            color: Colors.deepPurpleAccent,
            child: ListTile(
              onTap: () {
                p.setBuffering(widget.index);
                p.isTrackInProgress(widget.track!);
                p.currentATrac(widget.track!, widget.capi);

                p.handlePlayButton(
                  track: widget.track!,
                  index: widget.index,
                );
              },
              title: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.capi!.imgUrl,
                    width: 50,
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Capítulo ${widget.track!.cap}",
                          style: const TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          widget.capi!.nombrelibro,
                          style: const TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // subtitle: Row(
              //   children: [
              //     Text(
              //       widget.track!.content,
              //       style: TextStyle(fontSize: 10.0, color: Theme.of(context).colorScheme.primaryVariant),
              //     ),
              //   ],
              // ),
              trailing: TrackPlayButton(
                track: widget.track,
                index: widget.index!,
                cai: widget.capi,
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).cardColor,
            height: 0,
          ), //
        ]);
      },
    );
  }
}
