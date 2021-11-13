import 'package:appls/models/models/Track.dart';

import 'Media.dart';
part 'Album.g.dart';

class Album {
  final int? id;
  final String? title;
  final String? content;
  final Media? media;
  final List<dynamic>? tracks;

  Album(this.id, this.title, this.content, this.media, this.tracks);
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
