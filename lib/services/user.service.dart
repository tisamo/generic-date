
import '../http-client/http-client.dart';
import '../models/user.dart';


Future<List<User>> getUsers() async {
  final response = await getHttp('users')  as List<User>;
  return response;
}
