import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import 'package:stylo_app/features/auth/data/models/reset_password_request_model.dart';
import 'package:stylo_app/features/auth/data/models/validate_otp_request_model.dart';

import '../models/change_password_request_model.dart';
import '../models/forgot_password_request_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/token_response_model.dart';
import '../models/user_model.dart';
import '../models/verify_email_request_model.dart';

class AuthRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  /// Login
  Future<TokenResponseModel> login(LoginRequestModel request) async {
    try {
      final Response response = await _apiClient.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      return TokenResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Register
  Future<void> register(RegisterRequestModel request) async {
    try {
      await _apiClient.post(ApiConstants.register, data: request.toJson());
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Verify Email
  Future<void> verifyEmail(VerifyEmailRequestModel request) async {
    try {
      await _apiClient.post(ApiConstants.verifyEmail, data: request.toJson());
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Forgot Password
  Future<void> forgotPassword(ForgotPasswordRequestModel request) async {
    try {
      await _apiClient.post(
        ApiConstants.forgotPassword,
        data: request.toJson(),
      );
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  Future<void> validateOtp(ValidateOtpRequestModel request) async {
    try {
      await _apiClient.post(ApiConstants.validateOtp, data: request.toJson());
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Reset Password
  Future<void> resetPassword(ResetPasswordRequestModel request) async {
    try {
      await _apiClient.post(ApiConstants.resetPassword, data: request.toJson());
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Change Password
  Future<void> changePassword(ChangePasswordRequestModel request) async {
    try {
      await _apiClient.post(
        ApiConstants.changePassword,
        data: request.toJson(),
      );
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _apiClient.post(ApiConstants.logout);
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Refresh Token
  Future<TokenResponseModel> refreshToken(String refreshToken) async {
    try {
      final Response response = await _apiClient.post(
        ApiConstants.refreshToken,
        data: {"refreshToken": refreshToken, "useCookies": false},
      );

      return TokenResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }

  /// Current User
  Future<UserModel> getCurrentUser() async {
    try {
      final Response response = await _apiClient.get(ApiConstants.me);

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");

      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }
}
