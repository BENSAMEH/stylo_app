import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class CollectionsItemWidget extends StatelessWidget {
  const CollectionsItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:   double.infinity,
      padding: EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color:        AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        children: [
          // Title
          Text(
            "Can't find what you're looking for?",
            textAlign: TextAlign.center,
            style: AppTextStyles.headingSmall,
          ),
          SizedBox(height: AppSizes.sm),

          // Subtitle
          Text(
            'Discover our exclusive limited-edition collections curated by global designers.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color:  AppColors.lightTextSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: AppSizes.md),

          // Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.lg,
                vertical:   AppSizes.sm,
              ),
            ),
            child: Text(
              'Explore Collections',
              style: AppTextStyles.buttonSmall,
            ),
          ),
        ],
      ),
    );
  }
}