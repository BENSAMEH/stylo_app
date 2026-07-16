import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/review_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/review_repo.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repository;
  final ReviewRepo reviewRepo = ReviewRepo();

  ProductDetailCubit(this.repository) : super(ProductDetailInitial());

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

  Future<void> addReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    try {
      print("========== ADD REVIEW ==========");
      print("ProductId: $productId");
      print("Comment: $comment");
      print("Rating: $rating");

      await reviewRepo.addReview(
        productId: productId,
        comment: comment,
        rating: rating,
      );

      print("REVIEW ADDED SUCCESSFULLY");

      await loadProduct(productId);
    } on DioException catch (e) {
      print(e.response?.data);

      // لو المستخدم أضاف Review قبل كده
      if (e.response?.data.toString().contains("UserAlreadyReviewed") ??
          false) {
        print("User already reviewed this product");
        return;
      }

      emit(ProductDetailError(e.toString()));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}
