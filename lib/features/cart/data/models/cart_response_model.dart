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
      cartId: json['cartId'] ?? '',
      // 🔧 لو السيرفر رجع items: null (كارت فاضي)، بنعتبرها List فاضية
      // بدل ما نعمل crash بـ type cast error
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e))
              .toList() ??
          [],
      // 🔧 نفس الحماية لأي رقم ممكن يرجع null
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0,
      totalDiscount: (json['totalDiscount'] as num?)?.toDouble() ?? 0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
    );
  }
}
