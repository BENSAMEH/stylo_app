import '../datasource/profile_remote_datasource.dart';
import '../models/user_model.dart';

class ProfileRepositoryImpl {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl(this.remoteDatasource);

  Future<UserModel> getCurrentUser() async {
    return await remoteDatasource.getCurrentUser();
  }
}
