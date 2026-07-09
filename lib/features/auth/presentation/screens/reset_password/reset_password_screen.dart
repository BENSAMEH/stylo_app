import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/utils/app_validators.dart';

import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:stylo_app/features/auth/presentation/screens/login/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().resetPassword(
          email: widget.email,
          otp: widget.otp,
          newPassword: _passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password changed successfully"),
            ),
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
            (_) => false,
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          appBar: AppBar(
            backgroundColor: AppColors.lightSurface,
            elevation: 0,
            leading: const BackButton(
              color: AppColors.lightTextPrimary,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.screenPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: AppSizes.lg),

                    Text(
                      "Stylo",
                      style: AppTextStyles.displayMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                    SizedBox(height: AppSizes.xl),

                    Icon(
                      Icons.lock_reset,
                      size: 80,
                      color: AppColors.primary,
                    ),

                    SizedBox(height: AppSizes.lg),

                    Text(
                      "Reset Password",
                      style: AppTextStyles.headingLarge,
                    ),

                    SizedBox(height: AppSizes.sm),

                    Text(
                      "Create a new password for your account.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightTextSecondary,
                      ),
                    ),

                    SizedBox(height: AppSizes.xl),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      validator: AppValidators.password,
                      decoration: InputDecoration(
                        hintText: "New Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: AppSizes.md),

                    TextFormField(
                      controller: _confirmController,
                      obscureText: _hideConfirm,
                      validator: AppValidators.confirmPassword(
                        _passwordController.text,
                      ),
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hideConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _hideConfirm = !_hideConfirm;
                            });
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: AppSizes.xxl),

                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.buttonHeight,
                      child: ElevatedButton(
                        onPressed:
                            isLoading ? null : _resetPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusLg,
                            ),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Reset Password",
                                style:
                                    AppTextStyles.buttonLarge,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}