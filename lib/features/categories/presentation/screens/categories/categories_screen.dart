import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/presentation/screens/cart/cart_screen.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_card_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_header_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/collections_item_widget.dart';
import 'package:stylo_app/features/home/data/models/category_model.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_state.dart';
import 'package:stylo_app/features/home/presentation/screens/home/home_screen.dart';
import 'package:stylo_app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تم حذف الـ BlocProvider تماماً من هنا لأنه بيقرا مباشرة من الـ Instance اللي فوق في الـ root
    return const _CategoriesView();
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

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
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // ── Error State ─────────────────────────────────────
            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off_outlined, size: 64, color: AppColors.lightTextSecondary),
                    SizedBox(height: AppSizes.md),
                    Text(
                      state.message,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.lightTextSecondary),
                    ),
                    SizedBox(height: AppSizes.lg),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().loadHome(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // ── Extract Categories ──────────────────────────────
            final categories = state is HomeSuccess
                ? state.categories
                : state is HomeCategoryFiltered
                ? state.categories
                : <CategoryModel>[];

            final isLoading = state is HomeLoading;

            return SingleChildScrollView(
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
                      color: AppColors.primary,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
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

                  // ── Dynamic Category Content ──────────────────────
                  isLoading
                      ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : categories.isEmpty
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'No categories found',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return Padding(
                          padding: EdgeInsets.only(bottom: AppSizes.md),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                context.read<HomeCubit>().filterByCategory(category.id);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                                      (route) => false,
                                );
                              },
                              child: CategoryCard(
                                title: category.name,
                              ),
                            ),
                          ));
                    },
                  ),

                  SizedBox(height: AppSizes.lg),

                  // ── Collections CTA ───────────────────────────────
                  const CollectionsItemWidget(),
                  SizedBox(height: AppSizes.lg),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}