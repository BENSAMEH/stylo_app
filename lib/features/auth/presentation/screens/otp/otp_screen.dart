import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late TextEditingController _pinCodeController;

  @override
  void initState() {
    super.initState();
    _pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        leading: const BackButton(color: AppColors.lightTextPrimary),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: AppSizes.md),

            // ── App name ───────────────────────────────────────
            Text(
              'Stylo',
              style: AppTextStyles.headingLarge.copyWith(
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Title ──────────────────────────────────────────
            Text(
              'Verification Code',
              style: AppTextStyles.displayMedium.copyWith(
                color: AppColors.lightTextPrimary,
              ),
            ),

            SizedBox(height: AppSizes.sm),

            // ── Subtitle ───────────────────────────────────────
            Text(
              'Enter the code sent to your email.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary,
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // ── OTP pin fields ─────────────────────────────────
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _pinCodeController,
              obscureText: false,
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              textStyle: AppTextStyles.headingMedium.copyWith(
                color: AppColors.primary,
              ),
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                fieldWidth: 70,
                fieldHeight: 60,
                shape: PinCodeFieldShape.box,
                selectedColor:      AppColors.primary,
                selectedFillColor:  AppColors.lightSurface,
                activeColor:        AppColors.primary,
                activeFillColor:    AppColors.lightSurface,
                inactiveColor:      AppColors.lightDivider,
                inactiveFillColor:  AppColors.lightSurface,
                borderWidth: 1.5,
              ),
            ),

            SizedBox(height: AppSizes.lg),

            // ── Resend code ────────────────────────────────────
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Didn't receive a code? ",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: wire to AuthCubit.sendOtp()
                        },
                        child: Text(
                          'Resend Code',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSizes.xxl),

            // ── Verify button ──────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: wire to AuthCubit.verifyOtp()
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                child: Text('Verify', style: AppTextStyles.buttonLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}