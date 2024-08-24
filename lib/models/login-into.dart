// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class LoginInfo {
  LoginInfo({required this.email, required this.pass});

  String email;
  String pass;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"email": email, "pass": pass};
}


// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);


class RefreshToken {
  RefreshToken({required this.message, required this.refreshToken});

  String refreshToken;
  String message;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"message": message, "refreshToken": refreshToken};

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(
      message: json['message'],
      refreshToken: json['refreshToken'],
    );
  }

}

class AccessToken {
  AccessToken({required this.accessToken});

  String accessToken;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"message": accessToken};

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      accessToken: json['accessToken'],
    );
  }

}