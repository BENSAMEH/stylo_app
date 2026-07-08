import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class CategoryHeaderWidget extends StatelessWidget {
  const CategoryHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // App name
        Text(
          'Stylo',
          style: AppTextStyles.headingLarge.copyWith(color: AppColors.primary),
        ),

        // Actions
        Row(
          children: [
            const Icon(Icons.search, color: AppColors.lightTextPrimary),
            SizedBox(width: AppSizes.sm),
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person, color: AppColors.primary, size: 20),
            ),
          ],
        ),
      ],
    );
  }
}