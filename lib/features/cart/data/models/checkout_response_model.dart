class CheckoutResponseModel {
  final String message;
  final String? unifiedCheckoutUrl;
  final String? paymentClientSecret;

  CheckoutResponseModel({
    required this.message,
    this.unifiedCheckoutUrl,
    this.paymentClientSecret,
  });

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
      message: json["message"] ?? "",
      unifiedCheckoutUrl: json["unifiedCheckoutUrl"],
      paymentClientSecret: json["paymentClientSecret"],
    );
  }
}
