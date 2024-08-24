import 'package:dio/dio.dart';
import 'package:generic_date/http-client/services/tokenService.dart';
import 'package:generic_date/models/message.dart';
import 'package:generic_date/provider/token-service.dart';
import 'package:generic_date/provider/userlist-provider.dart';
import 'package:generic_date/services/utils-service.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  late Dio dio;
  final SecureStorageService storage = SecureStorageService();

  factory HttpClient() {
    return _instance;
  }

  HttpClient._internal() {
    dio = Dio(BaseOptions(baseUrl: 'https://localhost:7241/'));
    dio.interceptors.add(DioInterceptor(storage));
  }

  Future<Response> post(String url, dynamic object) async {
    try {
      final response = await dio.post(url, data: object);
      return response;
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }

  Future<Response> put(String url, dynamic object) async {
    try {
      final response = await dio.put(url, data: object);
      return response;
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }

  Future<Response> get(String url) async {
    Options options = Options();
    options.headers?['Content-Type'] = 'application/json';
    try {
      final response = await dio.get(url);
      return response;
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }

  Future<Response> refreshToken() async {
    String? refreshToken = await storage.retrieveFile('refresh_token');
    print(refreshToken);
    try {
      final response = await dio.get('user/token', options:
      Options(headers: {'Content-type': 'application/json',
                        'RefreshToken': refreshToken}));
      return response;
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }
}

class DioInterceptor extends Interceptor {
  final SecureStorageService storage;
  late Dio dio;

  DioInterceptor(this.storage) {
    dio = Dio(BaseOptions(baseUrl: "https://localhost:7241/"));
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-Type'] = 'application/json';
    final token = await storage.retrieveFile("access_token");
    if (token != null) {
      options.headers['Authorization'] = token;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await getAccessToken();
        handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        handler.next(e);
      }
      return;
    }
    if (err.response?.statusCode == 400) {
      try {
        if(err.response?.data is Map<String, dynamic> ){
          final message = Message.fromJson(err.response?.data);
          showToast(message.message);
        }
      } catch (e){

      }

    }

    handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await storage.retrieveFile("access_token");
    final options = Options(
      method: requestOptions.method,
      headers: {'Authorization': token},
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
