import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AboutAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;

  const AboutAppBarWidget({super.key, required this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: onBack,
        child: const Icon(Icons.arrow_back, color: AppColors.lightTextPrimary),
      ),
      title: Text(
        'Bariq',
        style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
      ),
      actions: [
        const Icon(Icons.shopping_bag_outlined, color: AppColors.lightTextPrimary),
        const SizedBox(width: 16),
      ],
    );
  }
}