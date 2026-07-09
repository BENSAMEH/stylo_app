class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://accessories-eshop.runasp.net/api";

  // Auth
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String verifyEmail = "/auth/verify-email";
  static const String forgotPassword = "/auth/forgot-password";
  static const String changePassword = "/auth/change-password";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh-token";
  static const String me = "/auth/me";
  static const String validateOtp = "/auth/validate-otp";
  static const String resetPassword = "/auth/reset-password";
}
