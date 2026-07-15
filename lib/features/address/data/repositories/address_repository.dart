import '../datasource/address_remote_datasource.dart';
import '../models/address_model.dart';

class AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepository({AddressRemoteDataSource? remoteDataSource})
    : remoteDataSource = remoteDataSource ?? AddressRemoteDataSource();

  Future<List<AddressModel>> getAddresses() {
    return remoteDataSource.getAddresses();
  }

  // 🆕
  Future<AddressModel> addAddress(AddressModel address) {
    return remoteDataSource.addAddress(address);
  }
}
