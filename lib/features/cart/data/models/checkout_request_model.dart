class CheckoutRequestModel {
  final String shippingAddressId;
  final String paymentMethod;
  final String? couponCode;

  CheckoutRequestModel({
    required this.shippingAddressId,
    required this.paymentMethod,
    this.couponCode,
  });

  Map<String, dynamic> toJson() {
    return {
      "shippingAddressId": shippingAddressId,
      "paymentMethod": paymentMethod,
      if (couponCode != null) "couponCode": couponCode,
    };
  }
}
