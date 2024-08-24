import 'package:json_annotation/json_annotation.dart';
part 'user_image.g.dart';
@JsonSerializable()
class UserImage {
  UserImage({
    required this.url,
    this.id
  });
  int? id;
  String url;

  factory UserImage.fromJson(Map<String, dynamic> json) => _$UserImageFromJson(json);
  Map<String, dynamic> toJson() => _$UserImageToJson(this);


}

