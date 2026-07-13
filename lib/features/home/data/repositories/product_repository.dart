import '../datasource/product_remote_datasource.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductRepository {
  final ProductRemoteDatasource datasource;
  ProductRepository(this.datasource);

  Future<ProductModel>      getProductById(String id)        => datasource.getProductById(id);
  Future<List<ReviewModel>> getReviews(String productId)     => datasource.getReviews(productId);
}