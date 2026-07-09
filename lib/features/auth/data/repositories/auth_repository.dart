import 'package:stylo_app/core/services/shared_pref_service.dart';

import '../datasource/auth_remote_datasource.dart';
import '../models/change_password_request_model.dart';
import '../models/forgot_password_request_model.dart';
import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/token_response_model.dart';
import '../models/user_model.dart';
import '../models/verify_email_request_model.dart';
import '../models/reset_password_request_model.dart';
import '../models/validate_otp_request_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource =
      AuthRemoteDataSource();

  /// Login
  Future<TokenResponseModel> login(
    LoginRequestModel request,
  ) async {
    final token = await _remoteDataSource.login(request);

    await SharedPrefService.saveAccessToken(
      token.accessToken,
    );

    await SharedPrefService.saveRefreshToken(
      token.refreshToken,
    );

    await SharedPrefService.saveExpiry(
      token.expiresAtUtc.toIso8601String(),
    );

    return token;
  }

  /// Register
  Future<void> register(
    RegisterRequestModel request,
  ) async {
    await _remoteDataSource.register(request);
  }

  /// Verify Email
  Future<void> verifyEmail(
    VerifyEmailRequestModel request,
  ) async {
    await _remoteDataSource.verifyEmail(request);
  }

  /// Forgot Password
  Future<void> forgotPassword(
    ForgotPasswordRequestModel request,
  ) async {
    await _remoteDataSource.forgotPassword(request);
  }

  /// Change Password
  Future<void> changePassword(
    ChangePasswordRequestModel request,
  ) async {
    await _remoteDataSource.changePassword(request);
  }

  /// Logout
  Future<void> logout() async {
    await _remoteDataSource.logout();

    await SharedPrefService.clear();
  }

  /// Refresh Token
  Future<TokenResponseModel> refreshToken() async {
    final refreshToken =
        SharedPrefService.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception("No refresh token found");
    }

    final token =
        await _remoteDataSource.refreshToken(refreshToken);

    await SharedPrefService.saveAccessToken(
      token.accessToken,
    );

    await SharedPrefService.saveRefreshToken(
      token.refreshToken,
    );

    await SharedPrefService.saveExpiry(
      token.expiresAtUtc.toIso8601String(),
    );

    return token;
  }

  /// Current User
  Future<UserModel> getCurrentUser() async {
    return await _remoteDataSource.getCurrentUser();
  }

  /// Check Login
  bool isLoggedIn() {
    final token = SharedPrefService.getAccessToken();

    return token != null && token.isNotEmpty;
  }
/// Validate OTP
Future<void> validateOtp({
  required String email,
  required String otp,
}) async {
  await _remoteDataSource.validateOtp(
    ValidateOtpRequestModel(
      email: email,
      otp: otp,
    ),
  );
}

/// Reset Password
Future<void> resetPassword({
  required String email,
  required String otp,
  required String newPassword,
}) async {
  await _remoteDataSource.resetPassword(
    ResetPasswordRequestModel(
      email: email,
      otp: otp,
      newPassword: newPassword,
    ),
  );
}

 
}