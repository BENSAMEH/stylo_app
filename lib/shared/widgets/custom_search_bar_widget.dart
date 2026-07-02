import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';


class CustomSearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomSearchBarWidget({
    super.key,
    this.controller,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCardBg
              : AppColors.lightBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          border: Border.all(color: AppColors.lightDivider),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.lightTextSecondary, size: AppSizes.iconMd),
            SizedBox(width: AppSizes.sm),
            Expanded(
              child: readOnly
                  ? Text('Search accessories...', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightTextSecondary))
                  : TextField(
                      controller: controller,
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Search accessories...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightTextSecondary),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}