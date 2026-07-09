import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/change_password_request_model.dart';
import '../../data/models/forgot_password_request_model.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/verify_email_request_model.dart';
import '../../data/repositories/auth_repository.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _repository = AuthRepository();

  /// Login
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await _repository.login(
        LoginRequestModel(
          email: email,
          password: password,
        ),
      );

      emit(LoginSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Register
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(AuthLoading());

    try {
      await _repository.register(
        RegisterRequestModel(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        ),
      );

      emit(RegisterSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Verify Email
  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    emit(AuthLoading());

    try {
      await _repository.verifyEmail(
        VerifyEmailRequestModel(
          email: email,
          otp: otp,
        ),
      );

      emit(VerifyEmailSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Forgot Password
  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(AuthLoading());

    try {
      await _repository.forgotPassword(
        ForgotPasswordRequestModel(
          email: email,
        ),
      );

      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Change Password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(AuthLoading());

    try {
      await _repository.changePassword(
        ChangePasswordRequestModel(
          currentPassword: currentPassword,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        ),
      );

      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> validateOtp({
  required String email,
  required String otp,
}) async {
  emit(AuthLoading());

  try {
    await _repository.validateOtp(
      email: email,
      otp: otp,
    );

    emit(ValidateOtpSuccess());
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}
Future<void> resetPassword({
  required String email,
  required String otp,
  required String newPassword,
}) async {
  emit(AuthLoading());

  try {
    await _repository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );

    emit(ResetPasswordSuccess());
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}


  /// Logout
  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await _repository.logout();

      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Current User
  Future<void> getCurrentUser() async {
    emit(AuthLoading());

    try {
      final user = await _repository.getCurrentUser();

      emit(GetUserSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Refresh Token
  Future<void> refreshToken() async {
    try {
      await _repository.refreshToken();
    } catch (_) {}
  }

  bool isLoggedIn() {
    return _repository.isLoggedIn();
  }
}