import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class RegisterSuccess extends AuthState {}

class VerifyEmailSuccess extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class ValidateOtpSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ChangePasswordSuccess extends AuthState {}



class LogoutSuccess extends AuthState {}

class GetUserSuccess extends AuthState {
  final UserModel user;

  const GetUserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}