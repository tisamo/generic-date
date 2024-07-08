
import '../http-client/http-client.dart';
import '../models/user.dart';


Future<List<User>> getUsers() async {
  return await getHttp('users') as List<User>;
}
