import '../../data/models/product_model.dart';
import '../../data/models/review_model.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}
class ProductDetailLoading  extends ProductDetailState {}
class ProductDetailError    extends ProductDetailState {
  final String message;
  ProductDetailError(this.message);
}
class ProductDetailSuccess  extends ProductDetailState {
  final ProductModel      product;
  final List<ReviewModel> reviews;
  ProductDetailSuccess({required this.product, required this.reviews});
}