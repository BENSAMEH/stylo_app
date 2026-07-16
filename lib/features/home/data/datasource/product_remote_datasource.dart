import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductRemoteDatasource {
  final ApiClient apiClient;
  ProductRemoteDatasource(this.apiClient);

  Future<ProductModel> getProductById(String id) async {
    final response = await apiClient.get(ApiConstants.productById(id));
    return ProductModel.fromJson(response.data);
  }

  Future<List<ReviewModel>> getReviews(String productId) async {
    final response = await apiClient.get(
      '/reviews/$productId',
      data: {
        "productId": productId,
        "page": 1,
        "pageSize": 10,
      },
    );

    final data = response.data;

    print(data.runtimeType);
    print(data["reviews"].runtimeType);
    print(data["reviews"]["items"].runtimeType);
    print(data["reviews"]["items"]);

    final List<dynamic> items =
    List<dynamic>.from(data["reviews"]["items"]);

    return items
        .map((e) => ReviewModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
  Future<void> addReview({
  required String productId,
  required String comment,
  required double rating,
}) async {
    await apiClient.post(
      '/reviews/$productId',
      data: {
        'comment': comment,
        'rating': rating.toInt(),
      },
    );
}
}