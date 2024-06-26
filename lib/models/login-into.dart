// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class LoginInfo {
  LoginInfo({required this.email, required this.password});

  String email;
  String password;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
