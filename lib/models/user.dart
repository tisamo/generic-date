// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.id,
    required this.name,
    this.created,
    this.password,
    required this.email,
    required this.description,
    required this.image,
    required this.longitude,
    required this.latitude
  });

  String? id;
  String name;
  double longitude;
  double latitude;
  DateTime? created;
  String email;
  String description;
  String? password;
  String image;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    created: DateTime.parse(json["created"]),
    email: json["email"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "description": description,
    "latitude": latitude,
    "longitude": longitude,
    "image": image,
    "password": password
  };
}
