import 'package:equatable/equatable.dart';
import 'package:stylo_app/features/cart/data/models/checkout_response_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final CheckoutResponseModel response;

  const CheckoutSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure(this.message);

  @override
  List<Object?> get props => [message];
}
