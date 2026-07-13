import '../datasource/home_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/offer_model.dart';
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

  // تم تعديل الدالة لتستدعي الـ datasource المفلتر
  Future<List<OfferModel>> getOffers() async {
    // نقوم بجلب البيانات من الـ datasource الذي يقوم بالفلترة تلقائياً
    return await datasource.getOffers();
  }
}