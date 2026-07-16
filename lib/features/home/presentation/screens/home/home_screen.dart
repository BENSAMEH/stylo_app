import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/presentation/screens/cart/cart_screen.dart';
import 'package:stylo_app/features/categories/presentation/screens/categories/categories_screen.dart';
import 'package:stylo_app/features/home/data/models/category_model.dart';
import 'package:stylo_app/features/home/data/models/product_model.dart';
import 'package:stylo_app/features/home/data/models/offer_model.dart'; // استيراد موديل الـ Offers
import 'package:stylo_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:stylo_app/features/home/presentation/cubit/home_state.dart';
import 'package:stylo_app/features/home/presentation/screens/product_details/product_details_screen.dart';
import 'package:stylo_app/features/home/presentation/widgets/category_item_widget.dart';
import 'package:stylo_app/features/home/presentation/widgets/offer_banner_widget.dart';
import 'package:stylo_app/features/home/presentation/widgets/product_card_widget.dart';
import 'package:stylo_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:stylo_app/features/profile/presentation/screens/profile/profile_screen.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';
import 'package:stylo_app/shared/widgets/custom_search_bar_widget.dart';
import 'package:stylo_app/shared/widgets/section_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _selectedCategoryIndex = 0;
  int _bottomNavIndex        = 0;

  final List<IconData> _categoryIcons = [
    Icons.grid_view_outlined,
    Icons.diamond_outlined,
    Icons.star_outline,
    Icons.earbuds_outlined,
    Icons.watch_outlined,
    Icons.shopping_bag_outlined,
    Icons.wb_sunny_outlined,
  ];

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
      builder: (context, state) {

        // ── Error state ──────────────────────────────────────
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

        // ── Extract data from state ───────────────────────────
        final products = state is HomeSuccess
            ? state.products
            : state is HomeCategoryFiltered
            ? state.products
            : <ProductModel>[];

        final categories = state is HomeSuccess
            ? state.categories
            : state is HomeCategoryFiltered
            ? state.categories
            : <CategoryModel>[];

        // استخراج العروض الحقيقية القادمة من السيرفر
        final offers = state is HomeSuccess
            ? state.offers
            : state is HomeCategoryFiltered
            ? state.offers
            : <OfferModel>[];

        final isLoading = state is HomeLoading;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: AppBottomNavWidget(
            currentIndex: _bottomNavIndex,
            onTap: (index) {
              setState(() => _bottomNavIndex = index);
              switch (index) {
                case 0:
                  break;
                case 1:
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                        (route) => false,
                  );
                  break;
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
            child: CustomScrollView(
              slivers: [

                // ── Top bar ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.screenPadding,
                      vertical:   AppSizes.md,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius:          22,
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
                  ),
                ),

                // ── Search bar ────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                    child: const CustomSearchBarWidget(readOnly: true),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

                // ── Offer banner (الربط الديناميكي الجديد) ────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                    // لو الـ API لسه بيحمل أو فاضي بنخفيه بشكل آمن، غير كده بنعرض الداتا الحقيقية
                    child: isLoading
                        ? const SizedBox(height: 150, child: Center(child: CircularProgressIndicator()))
                        : offers.isEmpty
                        ? const SizedBox()
                        : OfferBannerWidget(offers: offers),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

                // ── Categories ────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                    child: SectionHeaderWidget(
                      title:       'Categories',
                      actionText:  'See All',
                      onActionTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 90,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : categories.isEmpty
                        ? const SizedBox()
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                      itemCount: categories.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: EdgeInsets.only(right: AppSizes.lg),
                            child: CategoryItemWidget(
                              name:       'All',
                              icon:       _categoryIcons[0],
                              isSelected: _selectedCategoryIndex == 0,
                              onTap: () {
                                setState(() => _selectedCategoryIndex = 0);
                                context.read<HomeCubit>().loadHome();
                              },
                            ),
                          );
                        }

                        final category = categories[index - 1];
                        return Padding(
                          padding: EdgeInsets.only(right: AppSizes.md),
                          child: CategoryItemWidget(
                            name:       category.name,
                            icon:       _categoryIcons[index % _categoryIcons.length],
                            isSelected: _selectedCategoryIndex == index,
                            onTap: () {
                              setState(() => _selectedCategoryIndex = index);
                              context.read<HomeCubit>().filterByCategory(category.id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

                // ── Featured ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                    child: SectionHeaderWidget(
                      title:       'Featured',
                      actionText:  'View More',
                      onActionTap: () {},
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

                isLoading
                    ? const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()))
                    : products.isEmpty
                    ? SliverToBoxAdapter(
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
                )
                    : SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:  2,
                      mainAxisSpacing:  AppSizes.md,
                      crossAxisSpacing: AppSizes.md,
                      mainAxisExtent:   AppSizes.productCardHeight,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final product = products[index];
                        return ProductCardWidget(
                          name:   product.name,
                          image:  product.imageUrl,
                          price:  product.price,
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
                ),

                SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),





              ],
            ),
          ),
        );
      },
    );
  }
}