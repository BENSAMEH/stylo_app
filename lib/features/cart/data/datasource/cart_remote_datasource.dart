import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';

import '../models/add_to_cart_request_model.dart';
import '../models/cart_response_model.dart';
import '../models/update_cart_request_model.dart';

class CartRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<CartResponseModel> getCart() async {
    final response = await _apiClient.get(ApiConstants.cart);
    return CartResponseModel.fromJson(response.data);
  }

  Future<void> addToCart(AddToCartRequestModel request) async {
    await _apiClient.post(ApiConstants.cartItems, data: request.toJson());
  }

  Future<void> updateItem(String itemId, UpdateCartRequestModel request) async {
    await _apiClient.put(
      ApiConstants.cartItemById(itemId),
      data: request.toJson(),
    );
  }

  Future<void> deleteItem(String itemId) async {
    await _apiClient.delete(ApiConstants.cartItemById(itemId));
  }
}
