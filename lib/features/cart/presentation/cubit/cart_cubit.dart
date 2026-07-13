import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/add_to_cart_request_model.dart';
import '../../data/models/update_cart_request_model.dart';
import '../../data/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit(this.repository) : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());

    try {
      final cart = await repository.getCart();
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(AddToCartRequestModel request) async {
    emit(CartLoading());

    try {
      await repository.addToCart(request);

      await getCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateItem(String itemId, UpdateCartRequestModel request) async {
    emit(CartLoading());

    try {
      await repository.updateItem(itemId, request);

      await getCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> deleteItem(String itemId) async {
    emit(CartLoading());

    try {
      await repository.deleteItem(itemId);

      await getCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
