import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/routing/navigation_cubit.dart';

class EmptyCartContent extends StatelessWidget {
  const EmptyCartContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.screenPadding),
      child: Column(
        children: [
          SizedBox(height: AppSizes.md),

          // ── Empty illustration ─────────────────────────────
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 80,
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
          ),

          SizedBox(height: AppSizes.xl),

          // ── Empty label ────────────────────────────────────
          Text(
            'Your cart is empty',
            style: AppTextStyles.headingLarge.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),

          SizedBox(height: AppSizes.md),

          Text(
            'Discover our curated collection of luxury\naccessories and find something\nexceptional today.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),

          SizedBox(height: AppSizes.xl),

          // ── Continue shopping button ───────────────────────
          SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeight,
            child: ElevatedButton(
              onPressed: () => context.read<NavigationCubit>().setTab(0),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CONTINUE SHOPPING',
                    style: AppTextStyles.buttonSmall,
                  ),
                  SizedBox(width: AppSizes.sm),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),

          SizedBox(height: AppSizes.md),

          // ── Wishlist link ──────────────────────────────────
          GestureDetector(
            onTap: () {},
            child: Text(
              'VIEW WISHLIST',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),

          SizedBox(height: AppSizes.xxl),

          // ── Inspired section ───────────────────────────────
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'INSPIRED BY YOUR STYLE',
              style: AppTextStyles.caption.copyWith(
                color: theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),

          SizedBox(height: AppSizes.md),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (_) => Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Icon(
                  Icons.image_outlined,
                  color: theme.iconTheme.color?.withOpacity(0.6),
                ),
              ),
            ),
          ),

          SizedBox(height: AppSizes.lg),
        ],
      ),
    );
  }
}