import 'package:generic_date/models/role.dart';
import 'package:generic_date/models/user_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.created,
    this.infp,
    this.pass,
    this.birthday,
    this.username,
    required this.email,
    this.bio,
    this.images  = const [],
    this.hobbies  = const [],
    this.verified,
    this.roleName,
    this.longitude,
    this.latitude,
  });
  @JsonKey(defaultValue: [])
  final List<UserImage> images;
  @JsonKey(defaultValue: [])
  late final List<Role> hobbies;

  int? id;
  String? username;
  int? longitude;
  int? latitude;
  DateTime? created;
  String? birthday;
  String? infp;
  bool? verified;
  String email;
  String? bio;
  String? pass;
  String? roleName;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}


