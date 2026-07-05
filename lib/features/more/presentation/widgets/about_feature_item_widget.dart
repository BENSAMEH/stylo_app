import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AboutFeatureItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const AboutFeatureItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: AppSizes.iconMd),
        ),
        SizedBox(height: AppSizes.md),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.headingSmall,
        ),
        SizedBox(height: AppSizes.sm),

        // Description
        Text(
          description,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.lightTextSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}