import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
final backendUrl = 'https://localhost:7185/';
final dio = Dio();

makeGetRequest(subUrl) async {
  // make request
  final response = await http.get(Uri.parse('$backendUrl$subUrl'));
  // sample info available in response
  final statusCode = response.statusCode;

  if (statusCode == 200) {
    return (jsonDecode(response.body));
  } else {
    throw Exception('err');
  }

}

Future<Response> post(url, object) async {
  return dio.post('$backendUrl$url', data: object,
      onSendProgress: (int sent, int total) {
    print('$sent $total');
  });
}

getHttp(url, [token]) async {
  if(token?.length != 0){
    dio.options.headers = {
      'Authorization': token
    };
  }
  final response = await dio.get(backendUrl + url);

  print(response);
}

