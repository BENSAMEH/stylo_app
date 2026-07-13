import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/offer_model.dart'; // 👈 تأكد من استيراد موديل الـ Offers الجديد

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
  final List<OfferModel>    offers; // 👈 أضفنا الـ Offers هنا

  HomeSuccess({
    required this.products,
    required this.categories,
    required this.offers,
  });
}

class HomeCategoryFiltered extends HomeState {
  final List<ProductModel>  products;
  final List<CategoryModel> categories;
  final List<OfferModel>    offers; // 👈 لازم تفضل هنا عشان البانر ما يختفيش وقت الفلترة
  final int selectedCategoryId;

  HomeCategoryFiltered({
    required this.products,
    required this.categories,
    required this.offers,
    required this.selectedCategoryId,
  });
}