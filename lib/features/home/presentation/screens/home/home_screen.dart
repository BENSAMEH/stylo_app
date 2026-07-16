import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/routing/navigation_cubit.dart';
import 'package:stylo_app/features/home/data/models/category_model.dart';
import 'package:stylo_app/features/home/data/models/product_model.dart';
import 'package:stylo_app/features/home/data/models/offer_model.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_state.dart';
import 'package:stylo_app/features/home/presentation/screens/product_details/product_details_screen.dart';
import 'package:stylo_app/features/home/presentation/widgets/category_item_widget.dart';
import 'package:stylo_app/features/home/presentation/widgets/offer_banner_widget.dart';
import 'package:stylo_app/features/home/presentation/widgets/product_card_widget.dart';
import 'package:stylo_app/shared/widgets/custom_search_bar_widget.dart';
import 'package:stylo_app/shared/widgets/section_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeError || previous is HomeError || previous is HomeInitial,
      builder: (context, state) {
        if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_outlined,
                    size: 64,
                    color: AppColors.textSecondary(context),
                  ),
                  SizedBox(height: AppSizes.md),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  SizedBox(height: AppSizes.lg),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadHome(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return const _HomeView();
      },
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Top bar ──────────────────────────────────
            const SliverToBoxAdapter(
              child: _HomeTopBar(),
            ),

            // ── Search bar ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: const CustomSearchBarWidget(readOnly: true),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

            // ── Offer banner ──────────────────────────────
            const SliverToBoxAdapter(
              child: _HomeOfferBannerSection(),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

            // ── Categories Header ──────────────────────────
            const SliverToBoxAdapter(
              child: _HomeCategoriesHeader(),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

            // ── Categories List ────────────────────────────
            const SliverToBoxAdapter(
              child: _HomeCategoriesListSection(),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

            // ── Featured Header ────────────────────────────
            const SliverToBoxAdapter(
              child: _HomeFeaturedHeader(),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

            // ── Products Grid ──────────────────────────────
            const _HomeProductsGridSection(),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),
          ],
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.screenPadding,
        vertical: AppSizes.md,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
          SizedBox(width: AppSizes.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stylo',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
            color: AppColors.textPrimary(context),
          ),
        ],
      ),
    );
  }
}

class _HomeOfferBannerSection extends StatelessWidget {
  const _HomeOfferBannerSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is! HomeError,
      builder: (context, state) {
        final isLoading = state is HomeLoading;
        final offers = state is HomeSuccess
            ? state.offers
            : state is HomeCategoryFiltered
                ? state.offers
                : <OfferModel>[];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          child: isLoading
              ? const SizedBox(
                  height: 150,
                  child: Center(child: CircularProgressIndicator()),
                )
              : offers.isEmpty
                  ? const SizedBox()
                  : OfferBannerWidget(offers: offers),
        );
      },
    );
  }
}

class _HomeCategoriesHeader extends StatelessWidget {
  const _HomeCategoriesHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
      child: SectionHeaderWidget(
        title: 'Categories',
        actionText: 'See All',
        onActionTap: () => context.read<NavigationCubit>().setTab(1),
      ),
    );
  }
}

class _HomeCategoriesListSection extends StatelessWidget {
  const _HomeCategoriesListSection();

  static const List<IconData> _categoryIcons = [
    Icons.grid_view_outlined,
    Icons.diamond_outlined,
    Icons.star_outline,
    Icons.earbuds_outlined,
    Icons.watch_outlined,
    Icons.shopping_bag_outlined,
    Icons.wb_sunny_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is! HomeError,
      builder: (context, state) {
        final isLoading = state is HomeLoading;
        final categories = state is HomeSuccess
            ? state.categories
            : state is HomeCategoryFiltered
                ? state.categories
                : <CategoryModel>[];

        final int? selectedCategoryId = state is HomeCategoryFiltered
            ? state.selectedCategoryId
            : null;

        int selectedCategoryIndex = 0;
        if (selectedCategoryId != null) {
          final indexInList =
              categories.indexWhere((c) => c.id == selectedCategoryId);
          if (indexInList != -1) {
            selectedCategoryIndex = indexInList + 1;
          }
        }

        return SizedBox(
          height: 90,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : categories.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                      itemCount: categories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: EdgeInsets.only(right: AppSizes.lg),
                            child: CategoryItemWidget(
                              name: 'All',
                              icon: _categoryIcons[0],
                              isSelected: selectedCategoryIndex == 0,
                              onTap: () {
                                context.read<HomeCubit>().clearFilter();
                              },
                            ),
                          );
                        }

                        final category = categories[index - 1];
                        return Padding(
                          padding: EdgeInsets.only(right: AppSizes.md),
                          child: CategoryItemWidget(
                            name: category.name,
                            icon: _categoryIcons[index % _categoryIcons.length],
                            isSelected: selectedCategoryIndex == index,
                            onTap: () {
                              context.read<HomeCubit>().filterByCategory(category.id);
                            },
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}

class _HomeFeaturedHeader extends StatelessWidget {
  const _HomeFeaturedHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
      child: SectionHeaderWidget(
        title: 'Featured',
        actionText: 'View More',
        onActionTap: () {},
      ),
    );
  }
}

class _HomeProductsGridSection extends StatelessWidget {
  const _HomeProductsGridSection();

  void _goToProductDetail(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(productId: product.originalId!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is! HomeError,
      builder: (context, state) {
        final isLoading = state is HomeLoading;
        final products = state is HomeSuccess
            ? state.products
            : state is HomeCategoryFiltered
                ? state.products
                : <ProductModel>[];

        if (isLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (products.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Text(
                  'No products found',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ),
            ),
          );
        }

        return SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSizes.md,
              crossAxisSpacing: AppSizes.md,
              mainAxisExtent: AppSizes.productCardHeight,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = products[index];
                return ProductCardWidget(
                  name: product.name,
                  image: product.imageUrl,
                  price: product.price,
                  rating: 4.5,
                  onTap: () => _goToProductDetail(context, product),
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: products.length,
            ),
          ),
        );
      },
    );
  }
}