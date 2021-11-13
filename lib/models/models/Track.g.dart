// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    json['id'] as String,
    json['title'] as String,
    json['content'] as String,
    json['type'] as String,
    json['url'] as String,
    json['time'] as String,
    json['postType'] as String,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'url': instance.url,
      'postType': instance.postType,
      'time': instance.time,
    };
