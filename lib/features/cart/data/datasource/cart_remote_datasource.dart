import 'package:dio/dio.dart';

import '../models/add_to_cart_request_model.dart';
import '../models/cart_response_model.dart';
import '../models/update_cart_request_model.dart';

class CartRemoteDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://accessories-eshop.runasp.net',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<CartResponseModel> getCart() async {
    final response = await _dio.get('/api/cart');

    return CartResponseModel.fromJson(response.data);
  }

  Future<void> addToCart(AddToCartRequestModel request) async {
    await _dio.post('/api/cart/items', data: request.toJson());
  }

  Future<void> updateItem(String itemId, UpdateCartRequestModel request) async {
    await _dio.put('/api/cart/items/$itemId', data: request.toJson());
  }

  Future<void> deleteItem(String itemId) async {
    await _dio.delete('/api/cart/items/$itemId');
  }
}
