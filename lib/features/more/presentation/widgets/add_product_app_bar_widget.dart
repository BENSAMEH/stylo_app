import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AddProductAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onBack;

  const AddProductAppBarWidget({
    super.key,
    required this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,

      leading: GestureDetector(
        onTap: onBack,
        child: Icon(
          Icons.arrow_back,
          color: iconColor,
        ),
      ),

      title: Text(
        'Stylo',
        style: AppTextStyles.headingMedium.copyWith(
          color: AppColors.primary,
        ),
      ),

      actions: [
        Icon(
          Icons.notifications_none_outlined,
          color: iconColor,
        ),
        const SizedBox(width: 10),

        const CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.primary,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 18,
          ),
        ),

        const SizedBox(width: 16),
      ],
    );
  }
}