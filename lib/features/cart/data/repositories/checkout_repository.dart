import '../datasource/checkout_remote_datasource.dart';
import '../models/checkout_request_model.dart';
import '../models/checkout_response_model.dart';

class CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource = CheckoutRemoteDataSource();

  Future<CheckoutResponseModel> checkout(CheckoutRequestModel request) {
    return remoteDataSource.checkout(request);
  }
}
