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
    final Map<String, dynamic> headers = {
      'Accept':
          'application/json', // يضمن أن السيرفر يفهم الـ Response بصيغة JSON
    };

    if (token != null && token.isNotEmpty && token != "null") {
      headers["Authorization"] = "Bearer $token";
    }

    return Options(headers: headers);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    return await _dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: _getOptions(), // تمرير التوكن والـ headers بشكل نظيف ومستقل
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

  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data, options: _getOptions());
  }
}
