import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart'; // 👈 تأكد من استيراد موديل المنتجات
import '../../data/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  // 💾 هنحتفظ بنسخة كاش من كل المنتجات والكاتيجوريز عشان نفلتر منهم بسرعة Local
  List<ProductModel> _allProducts = [];
  List<CategoryModel> _allCategories = [];

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

      // حفظ الداتا في الكاش المحلي للـ Cubit
      _allProducts = products;
      _allCategories = categories;

      if (isClosed) return;

      // عرض كل المنتجات في البداية
      emit(HomeSuccess(products: _allProducts, categories: _allCategories));
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

    // 1. لو الـ state الحالية هي فلتر ونفس الـ categoryId اضغط عليه تاني، رجع كل المنتجات (Reset)
    final currentState = state;
    if (currentState is HomeCategoryFiltered && currentState.selectedCategoryId == categoryId) {
      emit(HomeSuccess(products: _allProducts, categories: _allCategories));
      return;
    }

    // 2. فلترة المنتجات محلياً (Local) من الكاش اللي حفظناه في الـ loadHome
    final filteredProducts = _allProducts
        .where((product) => product.categoryId == categoryId)
        .toList();

    emit(HomeCategoryFiltered(
      products:           filteredProducts, // المنتجات المصفاة فقط
      categories:         _allCategories,   // الكاتيجوريز كاملة عشان تفضل معروضة فوق
      selectedCategoryId: categoryId,
    ));
  }
}