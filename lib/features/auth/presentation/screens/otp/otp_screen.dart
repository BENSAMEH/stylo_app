import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:stylo_app/features/auth/presentation/screens/login/login_screen.dart';

import 'package:stylo_app/features/auth/presentation/screens/reset_password/reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final bool isForPasswordReset;

  const OtpScreen({
    super.key,
     this.isForPasswordReset=false,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

void _validateOtp() {
    if (_otpController.text.trim().length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter the 6-digit OTP")),
      );
      return;
    }

    final email = widget.email;
    final otp = _otpController.text.trim();

    if (widget.isForPasswordReset) {
      // Flow A: Password Reset
      context.read<AuthCubit>().validateOtp(email: email, otp: otp);
    } else {
      // Flow B: Account Registration
      context.read<AuthCubit>().verifyEmail(email: email, otp: otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyEmailSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LoginScreen()
            ),
          );
        }
        if (state is ValidateOtpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ResetPasswordScreen(
                email: widget.email,
                otp: _otpController.text.trim(),
              ),
            ),
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
          backgroundColor: AppColors.background(context),
          appBar: AppBar(
            backgroundColor: AppColors.surface(context),
            elevation: 0,
            leading:  BackButton(
              color: AppColors.textPrimary(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizes.md),

                Text(
                  "Stylo",
                  style: AppTextStyles.headingLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: AppSizes.xl),

                Text(
                  "Verification Code",
                  style: AppTextStyles.displayMedium,
                ),

                SizedBox(height: AppSizes.sm),

                Text(
                  "Enter the 6-digit code sent to\n${widget.email}",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),

                SizedBox(height: AppSizes.xl),

                PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  animationType: AnimationType.fade,
                  textStyle: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.primary,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(
                      AppSizes.radiusLg,
                    ),
                    fieldHeight: 55,
                    fieldWidth: 45,
                    activeFillColor: AppColors.surface(context),
                    selectedFillColor: AppColors.surface(context),
                    inactiveFillColor: AppColors.surface(context),
                    activeColor: AppColors.primary,
                    selectedColor: AppColors.primary,
                    inactiveColor: AppColors.divider(context),
                  ),
                  onChanged: (_) {},
                ),

                SizedBox(height: AppSizes.lg),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      context.read<AuthCubit>().forgotPassword(
                            email: widget.email,
                          );
                    },
                    child: Text(
                      "Resend Code",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.xxl),
            // ── Verify button ──────────────────────────────────
                           SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed:
                        isLoading ? null : _validateOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusFull,
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Continue",
                            style: AppTextStyles.buttonLarge,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}