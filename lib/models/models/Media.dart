import 'package:json_annotation/json_annotation.dart';
part 'Media.g.dart';

@JsonSerializable(
  checked: true,
)
class Media {
  final String thumbnail;
  final String medium;
  final String large;
  final String cover;
  Media(this.thumbnail, this.medium, this.large, this.cover);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
