import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_constants.dart';

import '../../../../core/api/api_client.dart';
import '../models/address_model.dart';

class AddressRemoteDatasource {
  final ApiClient apiClient;

  AddressRemoteDatasource(this.apiClient);

  Future<List<AddressModel>> getAddresses() async {
  try {
    final response = await apiClient.get(ApiConstants.addresses);

    print("STATUS: ${response.statusCode}");
    print("DATA: ${response.data}");

    return (response.data as List)
        .map((e) => AddressModel.fromJson(e))
        .toList();
  } on DioException catch (e) {
    print("STATUS: ${e.response?.statusCode}");
    print("DATA: ${e.response?.data}");
    rethrow;
  }
}

 Future<AddressModel> addAddress(AddressModel address) async {
  try {
    final response = await apiClient.post(
      '/addresses',
      data: address.toJson(),
    );

    return AddressModel.fromJson(response.data);
  } on DioException catch (e) {
    print("STATUS: ${e.response?.statusCode}");
    print("BODY: ${e.requestOptions.data}");
    print("RESPONSE: ${e.response?.data}");
    rethrow;
  }
}
}