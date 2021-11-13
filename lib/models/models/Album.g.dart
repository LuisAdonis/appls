// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) {
  return Album(
    json['id'] as int,
    json['title'] as String,
    json['content'] as String,
    json['media'] == null ? null : Media.fromJson(json['media'] as Map<String, dynamic>),
    (json['tracks'] as List).map((e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'media': instance.media?.toJson(),
      'tracks': instance.tracks!.map((e) => e?.toJson()).toList(),
    };
