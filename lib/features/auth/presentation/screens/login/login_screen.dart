import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: Column(
            children: [
              SizedBox(height: AppSizes.xxl),

              // ── App name ─────────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Stylo',
                  style: AppTextStyles.displayLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.xxl),

              // ── Welcome text ─────────────────────────────────
              Text(
                'Welcome back',
                style: AppTextStyles.headingLarge,
              ),

              SizedBox(height: AppSizes.sm),

              Text(
                'Experience the pinnacle of luxury accessories.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),

              SizedBox(height: AppSizes.lg),

              // ── Email label ──────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email Address',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.sm),

              // ── Email field ──────────────────────────────────
              TextField(
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'name@example.com',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                    color: AppColors.lightTextSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.lightSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.md),

              // ── Password label + forgot ──────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              // ── Password field ───────────────────────────────
              TextField(
                obscureText: true,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.lightTextSecondary,
                  ),
                  suffixIcon: const Icon(
                    Icons.visibility_outlined,
                    color: AppColors.lightTextSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.lightSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.xl),

              // ── Login button ─────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    ),
                  ),
                  child: Text(
                    'Login  →',
                    style: AppTextStyles.buttonLarge,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.xl),

              // ── OR divider ───────────────────────────────────
              Text(
                'OR CONTINUE WITH',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.lightTextSecondary,
                  letterSpacing: 1,
                ),
              ),

              SizedBox(height: AppSizes.lg),

              // ── Social buttons ───────────────────────────────
              Row(
                children: [
                  _SocialButton(
                    child: const Icon(
                      Icons.g_mobiledata,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: AppSizes.sm),
                  _SocialButton(
                    child: const Icon(
                      Icons.apple,
                      size: 30,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(width: AppSizes.sm),
                  _SocialButton(
                    child: const Icon(
                      Icons.facebook,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ── Sign up row ──────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.md),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable social button ───────────────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  final Widget child;
  const _SocialButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: AppSizes.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.07),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}