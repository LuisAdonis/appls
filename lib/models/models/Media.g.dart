// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Media _$MediaFromJson(Map<String, dynamic> json) {
  return $checkedNew('Media', json, () {
    final val = Media(
      $checkedConvert(json, 'thumbnail', (v) => v as String),
      $checkedConvert(json, 'medium', (v) => v as String),
      $checkedConvert(json, 'large', (v) => v as String),
      $checkedConvert(json, 'cover', (v) => v as String),
    );
    return val;
  });
}

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'medium': instance.medium,
      'large': instance.large,
      'cover': instance.cover,
    };
