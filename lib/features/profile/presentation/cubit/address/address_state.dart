import 'package:stylo_app/features/profile/data/models/address_model.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
  final List<AddressModel> addresses;

  AddressSuccess(this.addresses);
}

class AddressFailure extends AddressState {
  final String error;

  AddressFailure(this.error);
}
