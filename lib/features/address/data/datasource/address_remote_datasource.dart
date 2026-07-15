import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';

import '../models/address_model.dart';

class AddressRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  Future<List<AddressModel>> getAddresses() async {
    final response = await _apiClient.get(ApiConstants.addresses);
    final data = response.data as List<dynamic>;
    return data.map((e) => AddressModel.fromJson(e)).toList();
  }

  // 🆕 إضافة عنوان جديد عبر POST /api/addresses
  Future<AddressModel> addAddress(AddressModel address) async {
    final response = await _apiClient.post(
      ApiConstants.addresses,
      data: address.toJson(),
    );
    return AddressModel.fromJson(response.data);
  }
}
