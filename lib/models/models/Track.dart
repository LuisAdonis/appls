// ignore: file_names
import 'package:firebase_database/firebase_database.dart';

import 'Media.dart';

part 'Track.g.dart';

class Track {
  final String id;
  final String title;
  final String content;
  final String type;
  final String url;
  final String postType;
  final String time;
  Track(this.id, this.title, this.content, this.type, this.url, this.time, this.postType);

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);

  Track.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        title = snapshot.value["title"],
        content = snapshot.value["content"],
        type = snapshot.value["type"],
        url = snapshot.value["url"],
        postType = snapshot.value["postType"],
        time = snapshot.value["time"];
}
