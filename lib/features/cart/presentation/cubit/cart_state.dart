import '../../data/models/cart_response_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartResponseModel cart;

  CartLoaded(this.cart);
}

class CartSuccess extends CartState {}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
