import '../../../../core/api/api_client.dart';
import '../models/address_model.dart';

class AddressRemoteDatasource {
  final ApiClient apiClient;

  AddressRemoteDatasource(this.apiClient);

  Future<List<AddressModel>> getAddresses() async {
    final response = await apiClient.get('/api/addresses');

    return (response.data as List)
        .map((e) => AddressModel.fromJson(e))
        .toList();
  }

  Future<AddressModel> addAddress(Map<String, dynamic> data) async {
    final response = await apiClient.post('/api/addresses', data: data);

    return AddressModel.fromJson(response.data);
  }
}
