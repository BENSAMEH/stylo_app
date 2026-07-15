import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/address_model.dart';
import '../../../data/repositories/address_repository_impl.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepositoryImpl repository;

  AddressCubit(this.repository) : super(AddressInitial());

  List<AddressModel> addresses = [];

  Future<void> getAddresses() async {
    try {
      emit(AddressLoading());

      addresses = await repository.getAddresses();

      emit(AddressSuccess(addresses));
    } catch (e) {
      emit(AddressFailure(e.toString()));
    }
  }

  Future<void> addAddress(Map<String, dynamic> data) async {
    try {
      emit(AddressLoading());

      await repository.addAddress(data);

      await getAddresses();
    } catch (e) {
      emit(AddressFailure(e.toString()));
    }
  }

  
}
