import 'package:stylo_app/features/more/datasource/product_remote_datasource.dart';
import 'package:stylo_app/features/more/models/add_product_request_model.dart';

class AddProductRepository {
  final ProductRemoteDataSource remoteDataSource = ProductRemoteDataSource();

  Future<void> addProduct(AddProductRequestModel request) {
    return remoteDataSource.addProduct(request);
  }
}
