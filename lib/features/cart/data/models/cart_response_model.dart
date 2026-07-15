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
    final items =
        (json['cartItems'] as List<dynamic>?)
            ?.map((e) => CartItemModel.fromJson(e))
            .toList() ??
        [];

    // 🔧 السيرفر مش بيرجع subtotal/totalDiscount/totalPrice على مستوى
    // الكارت، فبنحسبهم إحنا من مجموع كل item بدل ما نسيبهم صفر دايمًا
    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + (item.basePricePerUnit * item.quantity),
    );
    final totalPrice = items.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );
    final totalDiscount = subtotal - totalPrice;

    return CartResponseModel(
      cartId: json['cartId'] ?? '',
      items: items,
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? subtotal,
      totalDiscount:
          (json['totalDiscount'] as num?)?.toDouble() ?? totalDiscount,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? totalPrice,
    );
  }
}
