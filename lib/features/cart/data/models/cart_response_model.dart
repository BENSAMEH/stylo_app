import 'cart_item_model.dart';

class CartResponseModel {
  final String cartId;
  final List<CartItemModel> items;
  final double subtotal;
  final double totalDiscount;
  final double totalPrice;

  CartResponseModel({
    required this.cartId,
    required this.items,
    required this.subtotal,
    required this.totalDiscount,
    required this.totalPrice,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      cartId: json['cartId'],
      items: (json['items'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      totalDiscount: (json['totalDiscount'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
