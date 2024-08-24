// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserImage _$UserImageFromJson(Map<String, dynamic> json) => UserImage(
      url: json['url'] as String,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserImageToJson(UserImage instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };
