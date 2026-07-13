
import 'package:stylo_app/features/cart/data/models/checkout_response_model.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final CheckoutResponseModel response;

  CheckoutSuccess(this.response);
}

class CheckoutFailure extends CheckoutState {
  final String message;

  CheckoutFailure(this.message);
}
