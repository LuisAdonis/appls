// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist(
    id: json['id'] as String,
    name: json['name'] as String,
    content: json['content'] as String,
    media: json['media'] == null ? null : Media.fromJson(json['media'] as Map<String, dynamic>),
    designation: json['designation'] as String,
    albums: (json['albums'] as List).map((e) => e == null ? null : Album.fromJson(e as Map<String, dynamic>)).toList(),
    tracks: (json['tracks'] as List).map((e) => e == null ? null : Track.fromJson(e as Map<String, dynamic>)).toList(),
  );
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'media': instance.media,
      'designation': instance.designation,
      'tracks': instance.tracks,
      'albums': instance.albums,
    };
