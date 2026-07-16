import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/review_model.dart';
import '../../data/repositories/product_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repository;

  ProductDetailCubit(this.repository) : super(ProductDetailInitial());

  Future<void> loadProduct(String productId) async {
    print("LOAD PRODUCT START");

    emit(ProductDetailLoading());

    try {
      print("GET PRODUCT...");
      final product = await repository.getProductById(productId);

      print("PRODUCT LOADED");

      List<ReviewModel> reviews = [];

      try {
        print("GET REVIEWS...");
        reviews = await repository.getReviews(productId);
        print("REVIEWS COUNT = ${reviews.length}");
      } catch (e) {
        print("REVIEWS ERROR = $e");
      }

      emit(ProductDetailSuccess(
        product: product,
        reviews: reviews,
      ));
    } catch (e) {
      print("PRODUCT ERROR = $e");
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