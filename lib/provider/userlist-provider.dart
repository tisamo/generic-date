import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_date/models/user_image.dart';
import 'package:generic_date/services/utils-service.dart';
import '../http-client/http-client.dart';
import '../models/login-into.dart';
import '../models/role.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  List<User> queriedUsers = [];
  final HttpClient http = HttpClient();

  bool isAuthenticated = false;
  get token => null;

  setUser(User newUser){
    user = newUser;
    notifyListeners();
  }

  void addToSelectedHobbies(Role hobby) {
    if (!user!.hobbies.any((el) => el.id == hobby.id)) {
      if(user!.hobbies.length==5){
        showToast('You can max have 5 hobbies');
        return;
      }

        user!.hobbies.add(hobby);
    } else {
      user!.hobbies.removeWhere((el) => el.id == hobby.id);
    }
    notifyListeners();
  }

  setUserHobbies(List<Role> hobbies){
    user!.hobbies = hobbies;
    notifyListeners();
  }

  addImageToUser(UserImage userImage){
    user!.images.add(userImage);
    notifyListeners();
  }
  updateQueriedUsers(List<User> fetchedUser){
    queriedUsers = fetchedUser;
    notifyListeners();
  }

  removeLastItemFromQueriedList(){
    queriedUsers.removeLast();
    notifyListeners();
  }

  Future<void> updateUserHobbies() async {
    try {
      final response = await http.put('hobby/user', user!.hobbies.map((h)=>h.toJson()).toList());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }

  }

  Future<List<User>?> getUsers() async{
    try {
      final response = await http.get('match/find');
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
        List<User> userList = responseData.map((data){
          return User.fromJson(data);
        }).toList();
        return userList;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }


  Future<bool> verifyUser(String code) async {
    try {
      final response = await http.get('user/verify/$code');
      if (response.statusCode == 200) {
        user!.verified = true;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<bool> setInitialSettings(String name, String date) async {
    try {
      final response = await http.get('user/init/$name/$date');
      if (response.statusCode == 200) {
        user!.username = name;
        user!.birthday = date;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

   Future<User> getUser() async {
    try {
      final response = await http.get('user');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
        User user = User.fromJson(responseData);
        setUser(user);
        return user;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<List<Role>> getUserHobbies() async {
    try {
      final response = await http.get('hobby/user');
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
        List<Role> hobbies = responseData.map((hobby){
         return Role.fromJson(hobby);
        }).toList();
        return hobbies;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> DeleteImage(UserImage userImage) async {
    try {
      final response = await http.post('user/image/delete', userImage.toJson());
      if (response.statusCode == 200) {
        user!.images.removeWhere((i)=>i.id == userImage.id);
        notifyListeners();
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Failed to login: $e');
    }
  }

  Future<List<UserImage>> fetchUserImages() async {
    try {
      final response = await http.get('user/images' );

      if (response.data is List) {
        final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);

        List<UserImage> userList = responseData.map((entry) {
          return UserImage.fromJson(entry);
        }).toList();

        return userList;
      } else {
        throw Exception('Unexpected response data type');
      }
    } catch (e) {
      print('Error fetching user images: $e');
      return [];
    }
  }

  Future<RefreshToken> login(LoginInfo loginInfos) async {
    try {
      final response = await http.post('user/login', loginInfos.toJson());

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

        return RefreshToken.fromJson(responseData);
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Failed to login: $e');
    }
  }

  Future<UserImage> uploadImage(FormData body) async {
    try {
      final response = await http.post('user/image', body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
        UserImage image = UserImage.fromJson(responseData);
        return image;
      } else {
        throw Exception('Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }


}
