import 'package:stylo_app/core/api/api_client.dart';

import '../models/checkout_request_model.dart';
import '../models/checkout_response_model.dart';

class CheckoutRemoteDataSource {
  final ApiClient apiClient = ApiClient();

  Future<CheckoutResponseModel> checkout(CheckoutRequestModel request) async {
    final response = await apiClient.post(
      '/api/orders/checkout',
      data: request.toJson(),
    );

    return CheckoutResponseModel.fromJson(response.data);
  }
}
