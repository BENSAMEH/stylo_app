import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/product_repository.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repository;
  ProductDetailCubit(this.repository) : super(ProductDetailInitial());

  // 1. تغيير الـ Parameter هنا من String إلى int ليطابق الـ UI والـ Models عندك
  Future<void> loadProduct(int productId) async {
    emit(ProductDetailLoading());
    try {
      // 2. تمرير الـ int للـ repository
      final product = await repository.getProductById(productId);

      // إذا كانت دالة الـ reviews مستنية String، ممكن تحولها مؤقتاً لـ toString()
      // أو تعدلها في الـ repository لـ int برضه
      final reviews = await repository.getReviews(productId);

      emit(ProductDetailSuccess(product: product, reviews: reviews));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}