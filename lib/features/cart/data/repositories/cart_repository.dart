import '../datasource/cart_remote_datasource.dart';
import '../models/add_to_cart_request_model.dart';
import '../models/cart_response_model.dart';
import '../models/update_cart_request_model.dart';

class CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepository({CartRemoteDataSource? remoteDataSource})
    : remoteDataSource = remoteDataSource ?? CartRemoteDataSource();

  Future<CartResponseModel> getCart() {
    return remoteDataSource.getCart();
  }

  Future<void> addToCart(AddToCartRequestModel request) {
    return remoteDataSource.addToCart(request);
  }

  Future<void> updateItem(String itemId, UpdateCartRequestModel request) {
    return remoteDataSource.updateItem(itemId, request);
  }

  Future<void> deleteItem(String itemId) {
    return remoteDataSource.deleteItem(itemId);
  }
}
