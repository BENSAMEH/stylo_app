import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylo_app/features/more/models/add_product_request_model.dart';
import 'package:stylo_app/features/more/presentation/cubit/add_product_state.dart';
import 'package:stylo_app/features/more/repositories/add_product_repository.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final AddProductRepository repository;

  AddProductCubit(this.repository) : super(AddProductInitial());

  Future<void> addProduct(AddProductRequestModel request) async {
    emit(AddProductLoading());

    try {
      await repository.addProduct(request);

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductError(e.toString()));
    }
  }
}
