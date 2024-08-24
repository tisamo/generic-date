// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      infp: json['infp'] as String?,
      pass: json['pass'] as String?,
      birthday: json['birthday'] as String?,
      verified: json['verified'] as bool?,
      username: json['username'] as String?,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => UserImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      hobbies: (json['hobbies'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      roleName: json['roleName'] as String?,
      longitude: (json['longitude'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'images': instance.images,
      'hobbies': instance.images,
      'id': instance.id,
      'userName': instance.username,
      'longitude': instance.longitude,
      'verified': instance.verified,
      'latitude': instance.latitude,
      'created': instance.created?.toIso8601String(),
      'birthday': instance.birthday,
      'infp': instance.infp,
      'email': instance.email,
      'bio': instance.bio,
      'pass': instance.pass,
      'roleName': instance.roleName,
    };
