import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import 'package:stylo_app/features/home/data/models/review_model.dart';

class ReviewRepo {
  final ApiClient _apiClient = ApiClient();

  Future<List<ReviewModel>> getReviews(String productId) async {
    final response = await _apiClient.get(
      ApiConstants.reviewsByProduct(productId),
    );

    print(response.data);

    return [];
  }

  Future<void> addReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.addReview(productId),
        data: {
          "productId": productId,
          "comment": comment,
          "rating": rating.toInt(),
        },
      );

      print(response.data);
    } on DioException catch (e) {
      print("STATUS = ${e.response?.statusCode}");
      print("DATA = ${e.response?.data}");
      rethrow;
    }
  }
}
