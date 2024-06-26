import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:generic_date/models/Apiresponse.dart';
import '../http-client/http-client.dart';
import '../models/login-into.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  bool isAuthenticated = false;
  get token => null;

  void SetUser(User? mongoUser) {
    if(mongoUser == null){
      return;
    }
    isAuthenticated = true;
    user = mongoUser;
    notifyListeners();
  }
  void test(MongoUsers) {
    print('test');
  }

  Future<dynamic> getUser() async {
    return User.fromJson(makeGetRequest('user'));
  }

  Future<String?> login(LoginInfo loginInfos) async {
    final response = await post('user/login', jsonEncode(loginInfos));
    return response.toString();
  }

  Future<ApiResponse<User>?> authenticate(String jwtToken) async {
    final response = await getHttp('user/is-signed-in', jwtToken)  as ApiResponse<User>?;
    return response;
  }


}
