import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/review_model.dart';
import '../../data/repositories/product_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repository;
  ProductDetailCubit(this.repository) : super(ProductDetailInitial());

  // 1. تغيير الـ Parameter هنا من String إلى int ليطابق الـ UI والـ Models عندك
  Future<void> loadProduct(String productId) async {
    emit(ProductDetailLoading());
    try {
      final product = await repository.getProductById(productId);

      print("PRODUCT LOADED");

      List<ReviewModel> reviews = [];

      try {
        reviews = await repository.getReviews(productId);
      } catch (e) {
        print("REVIEWS ERROR");
        print(e);
      }

      emit(ProductDetailSuccess(product: product, reviews: reviews));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}