import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/features/categories/presentation/cubit/reveiw_state.dart';
// Removed incorrect/missing imports. The repository is injected dynamically.

class ReviewCubit extends Cubit<ReviewState> {
  // Use a dynamic type for the repository to avoid undefined class errors
  // The repository is expected to provide getReviews and addReview methods.
  final dynamic reviewRepo;

  ReviewCubit(this.reviewRepo) : super(ReviewInitial());

  Future<void> getReviews(String productId) async {
    emit(ReviewLoading());

    try {
      final reviews = await reviewRepo.getReviews(productId);

      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> addReview({
    required String productId,
    required String comment,
    required double rating,
  }) async {
    try {
      await reviewRepo.addReview(
        productId: productId,
        comment: comment,
        rating: rating,
      );

      await getReviews(productId);
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
