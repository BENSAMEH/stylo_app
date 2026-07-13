import '../datasource/home_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeRepository {
  final HomeRemoteDatasource datasource;
  HomeRepository(this.datasource);

  Future<List<CategoryModel>> getCategories() =>
      datasource.getCategories();

  Future<List<ProductModel>> getProducts() =>
      datasource.getProducts();

  Future<List<ProductModel>> getProductsByCategory(int categoryId) =>
      datasource.getProductsByCategory(categoryId);
}