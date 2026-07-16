import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductRemoteDatasource {
  final ApiClient apiClient;

  ProductRemoteDatasource(this.apiClient);

  Future<ProductModel> getProductById(String id) async {
    print("==== GET PRODUCT ====");

    final response = await apiClient.get(ApiConstants.productById(id));

    print(response.data);

    return ProductModel.fromJson(response.data);
  }

  Future<List<ReviewModel>> getReviews(String productId) async {
    final response = await apiClient.get(
      "/reviews/$productId",
      data: {"productId": productId, "page": 1, "pageSize": 3},
    );

    print(response.data);

    final List items = response.data["reviews"]["items"];

    return items.map((e) => ReviewModel.fromJson(e)).toList();
  }
}
