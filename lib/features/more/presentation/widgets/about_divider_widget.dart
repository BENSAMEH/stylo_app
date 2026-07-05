import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';

class AboutDividerWidget extends StatelessWidget {
  const AboutDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.lg),
      child: Divider(
        color: AppColors.lightDivider,
        thickness: 1,
      ),
    );
  }
}