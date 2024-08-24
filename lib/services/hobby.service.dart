


import '../http-client/http-client.dart';
import '../models/role.dart';

Future<List<Role>> getHobbies() async {
  try {
    final response = await HttpClient().get('hobby');
    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
      List<Role> hobbies = responseData.map((entry) {
        return Role.fromJson(entry);
      }).toList();
      return hobbies;
    } else {
      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to login: $e');
  }
}
