// ignore: file_names
import 'package:appls/models/models/Album.dart';
import 'package:appls/models/models/Media.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Track.dart';

part 'Artist.g.dart';

class Artist {
  final String id;
  final String name;
  final String content;
  final Media? media;
  final String? designation;
  final List<Track?>? tracks;
  final List<Album?>? albums;
  Artist({
    required this.id,
    required this.name,
    required this.content,
    required this.media,
    this.designation,
    this.albums,
    this.tracks,
  });
  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
  Artist.fromSnapshot(
    DataSnapshot snapshot,
  )   : id = snapshot.key!,
        name = snapshot.value["title"],
        content = snapshot.value["title"],
        albums = [],
        designation = "",
        tracks = [],
        media = snapshot.value["content"];
}
