import '../datasource/address_remote_datasource.dart';
import '../models/address_model.dart';

class AddressRepositoryImpl {
  final AddressRemoteDatasource remoteDatasource;

  AddressRepositoryImpl(this.remoteDatasource);

  Future<List<AddressModel>> getAddresses() {
    return remoteDatasource.getAddresses();
  }

  Future<AddressModel> addAddress(Map<String, dynamic> data) {
    return remoteDatasource.addAddress(data);
  }
}
