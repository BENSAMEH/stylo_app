import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class LabeledTextFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType keyboardType;
  final String? prefixText;
  final String? Function(String?)? validator;

  const LabeledTextFieldWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.prefixText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label.toUpperCase(),
          style: AppTextStyles.caption.copyWith(
            color: AppColors.lightTextSecondary,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: AppSizes.xs),

        // Field
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightTextSecondary.withOpacity(0.6),
            ),
            prefixText: prefixText,
            prefixStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightTextSecondary,
            ),
            filled: true,
            fillColor: AppColors.primary.withOpacity(0.05),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}