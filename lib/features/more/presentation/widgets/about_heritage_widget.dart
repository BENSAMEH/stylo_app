import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AboutHeritageWidget extends StatelessWidget {
  const AboutHeritageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Heritage',
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: AppSizes.md),
        Text(
          'Founded in the heart of the historic jewelry district, Bariq began as a private atelier dedicated to the pursuit of perfection. For four decades, our artisans have pushed the boundaries of metallurgical science and aesthetic design, creating pieces that are not merely accessories, but timeless heirlooms.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            height: 1.7,
          ),
        ),
      ],
    );
  }
}