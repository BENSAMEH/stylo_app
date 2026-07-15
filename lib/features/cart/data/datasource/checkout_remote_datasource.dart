import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';

import '../models/checkout_request_model.dart';
import '../models/checkout_response_model.dart';

class CheckoutRemoteDataSource {
  final ApiClient apiClient = ApiClient();

  Future<CheckoutResponseModel> checkout(CheckoutRequestModel request) async {
    try {
      final response = await apiClient.post(
        ApiConstants.checkout,
        data: request.toJson(),
      );

      return CheckoutResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      // ignore: avoid_print
      print("CHECKOUT STATUS: ${e.response?.statusCode}");
      // ignore: avoid_print
      print("CHECKOUT RESPONSE: ${e.response?.data}");
      rethrow;
    }
  }
}
