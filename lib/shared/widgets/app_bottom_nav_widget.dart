import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AppBottomNavWidget extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const AppBottomNavWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      // 1. Force the type to fixed so it doesn't become transparent/shifting
      type: BottomNavigationBarType.fixed,
      
      // 2. Explicitly set background and item colors
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey.shade400,
      
      selectedLabelStyle: AppTextStyles.caption.copyWith(color: AppColors.primary),
      unselectedLabelStyle: AppTextStyles.caption,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),     activeIcon: Icon(Icons.home),             label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), activeIcon: Icon(Icons.grid_view),       label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), activeIcon: Icon(Icons.shopping_bag), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline),    activeIcon: Icon(Icons.person),          label: 'Profile'),
      ],
    );
  }
}