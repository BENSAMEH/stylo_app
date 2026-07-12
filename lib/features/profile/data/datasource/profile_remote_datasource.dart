import 'package:stylo_app/core/api/api_constants.dart';

import '../../../../core/api/api_client.dart';
import '../models/user_model.dart';

class ProfileRemoteDatasource {
  final ApiClient apiClient;

  ProfileRemoteDatasource(this.apiClient);

  Future<UserModel> getCurrentUser() async {
    final response = await apiClient.get(ApiConstants.me);

    return UserModel.fromJson(response.data);
  }
}
