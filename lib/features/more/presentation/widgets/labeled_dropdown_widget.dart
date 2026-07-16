import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class LabeledDropdownWidget extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;

  const LabeledDropdownWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label.toUpperCase(),
          style: AppTextStyles.caption.copyWith(
            color: theme.textTheme.bodyMedium?.color,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),

        SizedBox(height: AppSizes.xs),

        // Dropdown
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,

              hint: Text(
                hint,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
              ),

              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: theme.iconTheme.color,
              ),

              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.textTheme.bodyLarge?.color,
              ),

              dropdownColor: theme.cardColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),

              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  )
                  .toList(),

              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}