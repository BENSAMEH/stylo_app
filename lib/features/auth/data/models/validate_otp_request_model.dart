class ValidateOtpRequestModel {
  final String email;
  final String otp;

  ValidateOtpRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "otp": otp,
    };
  }
}