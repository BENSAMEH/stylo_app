import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AboutSectionTitleWidget extends StatelessWidget {
  final String title;

  const AboutSectionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.headingLarge.copyWith(
            color: Theme.of(context).textTheme.headlineSmall?.color,
          ),
        ),
        SizedBox(height: AppSizes.sm),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(
              AppSizes.radiusFull,
            ),
          ),
        ),
      ],
    );
  }
}