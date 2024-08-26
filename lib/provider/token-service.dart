
import 'package:flutter/cupertino.dart';
import 'package:generic_date/services/navigator-service.dart';

import '../http-client/http-client.dart';
import '../http-client/services/tokenService.dart';
import '../models/login-into.dart';
SecureStorageService storage = SecureStorageService();

Future<void> getAccessToken() async {
  try {
    final response = await HttpClient().refreshToken();
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data as Map<
          String,
          dynamic>;
      AccessToken accessToken = AccessToken.fromJson(responseData);
      await storage.storeFile("access_token", accessToken.accessToken);
    } else {
      await logout();
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle errors
    await logout();
    throw Exception('Failed to login: $e');
  }
}

Future<void> logout() async {

  await storage.deleteFile("access_token");
  await storage.deleteFile("refresh_token");
  NavigationService.navigatorKey.currentState?.pushNamed('/login');
}
