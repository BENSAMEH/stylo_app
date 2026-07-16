import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/offer_model.dart'; // 👈 استيراد موديل الـ Offers
import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  // 💾 كاش محلي لكل البيانات بما فيهم الـ Offers
  List<ProductModel> _allProducts = [];
  List<CategoryModel> _allCategories = [];
  List<OfferModel> _allOffers = []; 

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> loadHome({bool force = false}) async {
    print("🎬 [HomeCubit] loadHome() STARTED! force=$force");
    if (isClosed) return;

    if (!force && _allProducts.isNotEmpty) {
      print("📦 [HomeCubit] Returning cached data!");
      emit(HomeSuccess(
        products: _allProducts,
        categories: _allCategories,
        offers: _allOffers,
      ));
      return;
    }

    emit(HomeLoading());
    try {
      print("🛰️ [HomeCubit] Requesting Categories...");
      final categories = await repository.getCategories();

      print("🛰️ [HomeCubit] Requesting Products...");
      final products   = await repository.getProducts();

      print("🛰️ [HomeCubit] Requesting Offers API...");
      final offers     = await repository.getOffers();

      _allProducts = products;
      _allCategories = categories;
      _allOffers = offers; 

      if (isClosed) return;

      emit(HomeSuccess(
        products: _allProducts,
        categories: _allCategories,
        offers: _allOffers, 
      ));
      print("✅ [HomeCubit] loadHome() SUCCESS!");
    } catch (e) {
      print("💥 [HomeCubit] loadHome() CATCH ERROR: $e");
      if (isClosed) return;
      emit(HomeError(e.toString()));
    }
  }

  void clearFilter() {
    if (isClosed) return;
    emit(HomeSuccess(
      products: _allProducts,
      categories: _allCategories,
      offers: _allOffers,
    ));
  }

  void filterByCategory(int categoryId) {
    if (isClosed) return;

    final currentState = state;
    if (currentState is HomeCategoryFiltered && currentState.selectedCategoryId == categoryId) {
      clearFilter();
      return;
    }

    final filteredProducts = _allProducts
        .where((product) => product.categoryId == categoryId)
        .toList();

    emit(HomeCategoryFiltered(
      products:           filteredProducts,
      categories:         _allCategories,
      offers:             _allOffers, 
      selectedCategoryId: categoryId,
    ));
  }
}