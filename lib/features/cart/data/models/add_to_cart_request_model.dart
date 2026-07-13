class AddToCartRequestModel {
  final String productId;
  final int quantity;

  AddToCartRequestModel({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {"productId": productId, "quantity": quantity};
  }
}
