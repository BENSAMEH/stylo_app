import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class SaveProductButtonWidget extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onDiscard;
  final bool isLoading;

  const SaveProductButtonWidget({
    super.key,
    required this.onSave,
    required this.onDiscard,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Save button
        SizedBox(
          width: double.infinity,
          height: AppSizes.buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
              textStyle: AppTextStyles.buttonLarge,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Save Product'),
          ),
        ),
        SizedBox(height: AppSizes.sm),

        // Discard draft
        GestureDetector(
          onTap: onDiscard,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: Text(
              'Discard Draft',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.lightTextSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}