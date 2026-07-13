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
  List<OfferModel> _allOffers = []; // 👈 كاش الـ Offers

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> loadHome() async {
    print("🎬 [HomeCubit] loadHome() STARTED!");
    if (isClosed) return;

    emit(HomeLoading());
    try {
      print("🛰️ [HomeCubit] Requesting Categories...");
      final categories = await repository.getCategories();

      print("🛰️ [HomeCubit] Requesting Products...");
      final products   = await repository.getProducts();

      print("🛰️ [HomeCubit] Requesting Offers API...");
      // 👈 نداء الـ API الجديد من الـ repository (باصي الـ page والـ pageSize هنا)
      final offers     = await repository.getOffers();

      // حفظ الداتا في الكاش المحلي للـ Cubit
      _allProducts = products;
      _allCategories = categories;
      _allOffers = offers; // 👈 حفظ العروض

      if (isClosed) return;

      // عرض كل المنتجات والعروض في البداية
      emit(HomeSuccess(
        products: _allProducts,
        categories: _allCategories,
        offers: _allOffers, // 👈 تمرير العروض للـ UI
      ));
      print("✅ [HomeCubit] loadHome() SUCCESS!");
    } catch (e) {
      print("💥 [HomeCubit] loadHome() CATCH ERROR: $e");
      if (isClosed) return;
      emit(HomeError(e.toString()));
    }
  }

  /// دالة الفلترة الذكية
  void filterByCategory(int categoryId) {
    if (isClosed) return;

    // 1. لو الـ state الحالية هي فلتر ونفس الـ categoryId، ارجع للـ Success الحالة العامة
    final currentState = state;
    if (currentState is HomeCategoryFiltered && currentState.selectedCategoryId == categoryId) {
      emit(HomeSuccess(
        products: _allProducts,
        categories: _allCategories,
        offers: _allOffers,
      ));
      return;
    }

    // 2. فلترة المنتجات محلياً (Local) من الكاش
    final filteredProducts = _allProducts
        .where((product) => product.categoryId == categoryId)
        .toList();

    emit(HomeCategoryFiltered(
      products:           filteredProducts,
      categories:         _allCategories,
      offers:             _allOffers, // 👈 بنباصي نفس الـOffers المحفوظة عشان تفضل معروضة في البانر
      selectedCategoryId: categoryId,
    ));
  }
}