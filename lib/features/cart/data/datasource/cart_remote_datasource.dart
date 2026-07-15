import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';

import '../models/add_to_cart_request_model.dart';
import '../models/cart_response_model.dart';
import '../models/update_cart_request_model.dart';

class CartRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<CartResponseModel> getCart() async {
    final response = await _apiClient.get(ApiConstants.cart);

    // 🔍 مؤقتًا: نشوف شكل الكارت الحقيقي الراجع من السيرفر
    // ignore: avoid_print
    print("GET CART RESPONSE: ${response.data}");

    return CartResponseModel.fromJson(response.data);
  }

  Future<void> addToCart(AddToCartRequestModel request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.cartItems,
        data: request.toJson(),
      );

      // 🔍 مؤقتًا: نشوف شكل رد الإضافة نفسه (مش بس وقت الفشل)
      // ignore: avoid_print
      print("ADD TO CART SUCCESS RESPONSE: ${response.data}");
    } on DioException catch (e) {
      // ignore: avoid_print
      print("ADD TO CART STATUS: ${e.response?.statusCode}");
      // ignore: avoid_print
      print("ADD TO CART RESPONSE: ${e.response?.data}");
      rethrow;
    }
  }

  Future<void> updateItem(String itemId, UpdateCartRequestModel request) async {
    await _apiClient.put(
      ApiConstants.cartItemById(itemId),
      data: request.toJson(),
    );
  }
Future<void> deleteItem(String itemId) async {
    try {
      await _apiClient.delete(
        ApiConstants.cartItemById(itemId),
        // 🔧 السيرفر مستني Body فيه الـ id حتى مع إنها DELETE request
        // (شفنا كده في Scalar: Body required -> { "id": "uuid" })
        data: {"id": itemId},
      );
    } on DioException catch (e) {
      print("DELETE ITEM STATUS: ${e.response?.statusCode}");
      print("DELETE ITEM RESPONSE: ${e.response?.data}");
      rethrow;
    }
  }
}
