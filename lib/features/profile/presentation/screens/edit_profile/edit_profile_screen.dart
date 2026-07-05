import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/shared/widgets/custom_profile_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,

      appBar: AppBar(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
        ),
        title: Text(
          'Edit Profile',
          style: AppTextStyles.headingSmall,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            children: [

              // ── Profile avatar ─────────────────────────────────
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: AppSizes.avatarLg / 2,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: AppSizes.iconXl,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSizes.sm),

              // ── Change photo button ────────────────────────────
              TextButton(
                onPressed: () {
                  // TODO: wire to ProfileCubit.uploadPhoto()
                },
                child: Text(
                  'CHANGE PHOTO',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.md),

              // ── Full name ──────────────────────────────────────
              const CustomProfileTextField(
                label: 'FULL NAME',
                hint:  'Julian Alexander',
                icon:  Icons.person_outline,
              ),

              SizedBox(height: AppSizes.md),

              // ── Email ──────────────────────────────────────────
              const CustomProfileTextField(
                label: 'EMAIL ADDRESS',
                hint:  'julian.alex@bariq.luxury',
                icon:  Icons.email_outlined,
              ),

              SizedBox(height: AppSizes.md),

              // ── Phone ──────────────────────────────────────────
              const CustomProfileTextField(
                label: 'PHONE NUMBER',
                hint:  '+1 (234) 567-8901',
                icon:  Icons.phone_outlined,
              ),

              SizedBox(height: AppSizes.md),

              // ── Address ────────────────────────────────────────
              const CustomProfileTextField(
                label:       'PRIMARY ADDRESS',
                hint:        'Penthouse 4B, Sky Towers',
                icon:        Icons.location_on_outlined,
                suffixIcon:  Icon(Icons.arrow_forward_ios, size: 16),
              ),

              SizedBox(height: AppSizes.xl),

              // ── Save button ────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: wire to ProfileCubit.updateProfile()
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
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.white, size: 20),
                      SizedBox(width: AppSizes.sm),
                      Text('Save Changes', style: AppTextStyles.buttonLarge),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSizes.md),

              // ── Last updated ───────────────────────────────────
              Text(
                'Last updated: Today, 10:45 AM',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),

              SizedBox(height: AppSizes.md),
            ],
          ),
        ),
      ),
    );
  }
}