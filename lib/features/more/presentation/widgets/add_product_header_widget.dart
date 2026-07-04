import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AddProductHeaderWidget extends StatelessWidget {
  const AddProductHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add New Product',
          style: AppTextStyles.headingLarge,
        ),
        SizedBox(height: AppSizes.xs),
        Text(
          'Register high-end accessories to your active inventory.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.lightTextSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}