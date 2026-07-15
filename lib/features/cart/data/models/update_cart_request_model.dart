
class UpdateCartRequestModel {
  final int quantity;

  UpdateCartRequestModel({required this.quantity});

  Map<String, dynamic> toJson() {
    return {"quantity": quantity};
  }
}
