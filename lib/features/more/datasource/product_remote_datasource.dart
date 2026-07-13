import 'package:dio/dio.dart';

import 'package:stylo_app/features/more/models/add_product_request_model.dart';

class ProductRemoteDataSource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://accessories-eshop.runasp.net',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<void> addProduct(AddProductRequestModel request) async {
    final response = await _dio.post('/api/products', data: request.toJson());

    if (response.statusCode != 200) {
      throw Exception('Failed to add product');
    }
  }
}
