import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/review_model.dart';
import '../../data/repositories/product_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repository;

  ProductDetailCubit(this.repository) : super(ProductDetailInitial());

  Future<void> loadProduct(String productId) async {
    emit(ProductDetailLoading());
    try {
      final product = await repository.getProductById(productId);

      List<ReviewModel> reviews = [];
      try {
        reviews = await repository.getReviews(productId);
      } catch (_) {
        // reviews failing should not break the whole screen
      }

      emit(ProductDetailSuccess(product: product, reviews: reviews));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }

  Future<void> addReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    try {
      await repository.addReview(
        productId: productId,
        comment:   comment,
        rating:    rating,
      );
      // reload to show the new review
      await loadProduct(productId);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('UserAlreadyReviewed')) return;
      emit(ProductDetailError(msg));
    }
  }
}