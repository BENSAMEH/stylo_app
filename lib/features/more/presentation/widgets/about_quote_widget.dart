import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AboutQuoteWidget extends StatelessWidget {
  final String quote;
  final String author;

  const AboutQuoteWidget({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$quote"',
            style: AppTextStyles.bodyLarge.copyWith(
              color: onPrimary,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          SizedBox(height: AppSizes.md),
          Row(
            children: [
              Container(
                width: 24,
                height: 2,
                color: onPrimary.withOpacity(0.6),
              ),
              SizedBox(width: AppSizes.sm),
              Text(
                author,
                style: AppTextStyles.caption.copyWith(
                  color: onPrimary.withOpacity(0.85),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}