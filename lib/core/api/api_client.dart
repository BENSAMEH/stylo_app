import 'package:dio/dio.dart';
import '../services/shared_pref_service.dart';
import 'dio_provider.dart';

class ApiClient {
  final Dio _dio = DioProvider.dio;

  ApiClient() {
    _dio.interceptors.clear();
  }

  Options _getOptions() {
    final token = SharedPrefService.getAccessToken();

    print("================================");
    print("TOKEN = $token");

    final headers = {"Accept": "application/json"};

    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    print(headers);
    print("================================");

    return Options(headers: headers);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: 'GET', headers: _getOptions().headers),
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptions(),
    );
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data, options: _getOptions());
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path, options: _getOptions());
  }
}
