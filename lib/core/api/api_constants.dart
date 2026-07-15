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
// Addresses
  static const String addresses = "/addresses";
  // Products
  static const String products = "/products";
  static String productById(String id) => "/products/$id";
  static String deleteProduct(int id) => "/products/$id";

  // Categories
  static const String categories = "/categories";
  static String productsByCategory(int id) => "/products?categoryId=$id";

  // Cart
  static const String cart = "/cart";
  static const String cartItems = "/cart/items";
  static String cartItemById(String itemId) => "/cart/items/$itemId";
// Checkout
  static const String checkout = "/orders/checkout";  // Reviews
  static String reviewsByProduct(String productId) =>
      "/reviews/$productId?page=1&pageSize=10";
}
