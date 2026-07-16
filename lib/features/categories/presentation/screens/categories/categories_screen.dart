import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/routing/navigation_cubit.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_card_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/category_header_widget.dart';
import 'package:stylo_app/features/categories/presentation/widgets/collections_item_widget.dart';
import 'package:stylo_app/features/home/data/models/category_model.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CategoriesView();
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // ── Error State ─────────────────────────────────────
            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off_outlined, size: 64, color: AppColors.textSecondary(context)),
                    SizedBox(height: AppSizes.md),
                    Text(
                      state.message,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary(context)),
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
                          color: AppColors.textSecondary(context),
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
                                context.read<NavigationCubit>().setTab(0);
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