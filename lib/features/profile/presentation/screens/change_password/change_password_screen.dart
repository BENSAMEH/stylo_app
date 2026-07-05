import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/shared/widgets/custom_profile_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
        ),
        title: Text(
          'Change Password',
          style: AppTextStyles.headingSmall.copyWith(color: AppColors.primary),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: AppSizes.md),

            // ── Title ──────────────────────────────────────────
            Text(
              'Security Update',
              style: AppTextStyles.headingLarge,
            ),

            SizedBox(height: AppSizes.sm),

            // ── Subtitle ───────────────────────────────────────
            Text(
              'Ensure your account stays secure by choosing a strong, unique password.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary,
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Current password ───────────────────────────────
            const CustomProfileTextField(
              label:       'CURRENT PASSWORD',
              hint:        '••••••••',
              icon:        Icons.lock_outline,
              obscureText: true,
              suffixIcon:  Icon(Icons.visibility_outlined),
            ),

            SizedBox(height: AppSizes.md),

            // ── New password ───────────────────────────────────
            const CustomProfileTextField(
              label:       'NEW PASSWORD',
              hint:        '••••••••',
              icon:        Icons.lock_outline,
              obscureText: true,
              suffixIcon:  Icon(Icons.visibility_outlined),
            ),

            SizedBox(height: AppSizes.md),

            // ── Confirm new password ───────────────────────────
            const CustomProfileTextField(
              label:       'CONFIRM NEW PASSWORD',
              hint:        '••••••••',
              icon:        Icons.lock_outline,
              obscureText: true,
              suffixIcon:  Icon(Icons.visibility_outlined),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Update button ──────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: wire to AuthCubit.changePassword()
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Update Password', style: AppTextStyles.buttonLarge),
                    SizedBox(width: AppSizes.sm),
                    const Icon(Icons.check_circle_outline, color: AppColors.white),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSizes.xxl),

            // ── Encrypted badge ────────────────────────────────
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: AppSizes.avatarLg / 2,
                    backgroundImage: const NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBvgU0wqIfrP22MP2WgGBUGFVY3CBAbjagcEK8YMSmrF0Exq0A0WMyWrUHcCU1FuakQliFgPJ5CdLF4xcNK1qauno8FfGmbZMa1fIggyPSR93RG9RhgSaapU7Sk5pKQ0KJNS_z1j7LYJYBv4AmBu5Kevtbo5ehBbxGGSNhnbypW41S7flLFTH9RLyx87I5EKWPNZ0MQa07YqD8nVP4RAYxWbwnyzrU-Het6rqeEpUJEj4QBmYQtuCUM',
                    ),
                  ),
                  SizedBox(height: AppSizes.sm),
                  Text(
                    'YOUR BARIQ PROFILE IS ENCRYPTED AND PROTECTED',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.lightTextSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSizes.md),
          ],
        ),
      ),
    );
  }
}