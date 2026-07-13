import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductRemoteDatasource {
  final ApiClient apiClient;
  ProductRemoteDatasource(this.apiClient);

  Future<ProductModel> getProductById(int id) async {
    final response = await apiClient.get(ApiConstants.productById(id));
    return ProductModel.fromJson(response.data);
  }

  Future<List<ReviewModel>> getReviews(int productId) async {
    final response = await apiClient.get(
      ApiConstants.reviewsByProduct(productId),
    );
    final List data = response.data as List;
    return data.map((e) => ReviewModel.fromJson(e)).toList();
  }
}