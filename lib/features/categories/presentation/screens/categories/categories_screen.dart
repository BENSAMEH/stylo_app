import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/presentation/screens/cart/cart_screen.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_card_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_header_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_list_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/collections_item_widget.dart';

import 'package:stylo_app/features/home/presentation/screens/home/home_screen.dart';
import 'package:stylo_app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      bottomNavigationBar: AppBottomNavWidget(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
              break;
            case 1:
              break; // already here
            case 2:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
                (route) => false,
              );
              break;
            case 3:
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
                (route) => false,
              );
              break;
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Header ───────────────────────────────────────
              const CategoryHeaderWidget(),
              SizedBox(height: AppSizes.lg),

              // ── Section label ─────────────────────────────────
              Text(
                'CURATION',
                style: AppTextStyles.caption.copyWith(
                  color:         AppColors.primary,
                  letterSpacing: 1,
                  fontWeight:    FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSizes.xs),

              // ── Section title with underline ──────────────────
              Container(
                padding: EdgeInsets.only(bottom: AppSizes.xs),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.primary, width: 3),
                  ),
                ),
                child: Text(
                  'Browse Categories',
                  style: AppTextStyles.headingLarge,
                ),
              ),

              SizedBox(height: AppSizes.lg),

              // ── Category grid ─────────────────────────────────
              const CategoryListWidget(),
              SizedBox(height: AppSizes.md),

              // ── Watches banner card ───────────────────────────
              SizedBox(
                height: 150,
                width:  double.infinity,
                child: CategoryCard(
                  title: 'Watches',
                  image: 'assets/images/watches.png',
                  icon:  'assets/icons/watch.svg',
                ),
              ),

              SizedBox(height: AppSizes.xl),

              // ── Collections CTA ───────────────────────────────
              const CollectionsItemWidget(),

              SizedBox(height: AppSizes.lg),
            ],
          ),
        ),
      ),
    );
  }
}