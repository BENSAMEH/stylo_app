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
      queryParameters: {        // ← was data: (bug — GET ignores body)
        'page':     1,
        'pageSize': 10,
      },
    );

    final data = response.data;

    // handle all possible response shapes from the API
    List rawList = [];

    if (data is List) {
      rawList = data;
    } else if (data is Map) {
      if (data['reviews'] is List) {
        rawList = data['reviews'];
      } else if (data['reviews'] is Map && data['reviews']['items'] is List) {
        rawList = data['reviews']['items'];
      } else if (data['items'] is List) {
        rawList = data['items'];
      } else if (data['data'] is List) {
        rawList = data['data'];
      }
    }

    return rawList.map((e) => ReviewModel.fromJson(e)).toList();
  }
  Future<void> addReview({
  required String productId,
  required String comment,
  required double rating,
}) async {
  await apiClient.post(
    '/reviews',
    data: {
      'productId': productId,
      'comment':   comment,
      'rating':    rating,
    },
  );
}
}