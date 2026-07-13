import '../datasource/product_remote_datasource.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';

class ProductRepository {
  final ProductRemoteDatasource datasource;
  ProductRepository(this.datasource);

  Future<ProductModel>      getProductById(int id)        => datasource.getProductById(id);
  Future<List<ReviewModel>> getReviews(int productId)     => datasource.getReviews(productId);
}