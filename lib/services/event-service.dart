import '../http-client/http-client.dart';
import '../models/event.dart';


Future<List<Event>> getEvents() async {
  final response = await getHttp('events');

  return response as List<Event>;
}