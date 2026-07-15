import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/features/cart/data/repositories/checkout_repository.dart';
import 'package:stylo_app/features/cart/presentation/cubit/checkout_state.dart';

import '../../data/models/checkout_request_model.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepository repository;

  CheckoutCubit(this.repository) : super(CheckoutInitial());

  Future<void> checkout({
    required String shippingAddressId,
    required String paymentMethod,
    String? couponCode,
  }) async {
    emit(CheckoutLoading());

    try {
      final response = await repository.checkout(
        CheckoutRequestModel(
          shippingAddressId: shippingAddressId,
          paymentMethod: paymentMethod,
          couponCode: couponCode,
        ),
      );

      emit(CheckoutSuccess(response));
    } catch (e) {
      emit(CheckoutFailure(e.toString()));
    }
  }
}
