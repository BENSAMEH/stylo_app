import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';

abstract class HomeState {}

class HomeInitial  extends HomeState {}
class HomeLoading  extends HomeState {}
class HomeError    extends HomeState {
  final String message;
  HomeError(this.message);
}
class HomeSuccess  extends HomeState {
  final List<ProductModel>  products;
  final List<CategoryModel> categories;
  HomeSuccess({required this.products, required this.categories});
}
class HomeCategoryFiltered extends HomeState {
  final List<ProductModel>  products;
  final List<CategoryModel> categories;
  final int selectedCategoryId;
  HomeCategoryFiltered({
    required this.products,
    required this.categories,
    required this.selectedCategoryId,
  });
}