import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/home/presentation/widgets/category_item_widget.dart';
import 'package:stylo_app/features/home/presentation/widgets/offer_banner_widget.dart';
import 'package:stylo_app/features/home/presentation/widgets/product_card_widget.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';
import 'package:stylo_app/shared/widgets/custom_search_bar_widget.dart';
import 'package:stylo_app/shared/widgets/section_header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  int _bottomNavIndex   = 0;

  // Dummy category data
  final List<Map<String, dynamic>> _categoryIcons = [
    {'icon': Icons.diamond_outlined,  'name': 'Rings'},
    {'icon': Icons.star_outline,      'name': 'Necklaces'},
    {'icon': Icons.earbuds_outlined,  'name': 'Earrings'},
    {'icon': Icons.watch_outlined,    'name': 'Watches'},
  ];

  // Dummy offers
  final List<Map<String, String>> _dummyOffers = [
    {
      'title':      'New Season Collection',
      'subtitle':   'Up to 30% Off Premium Deals',
      'image':      'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800',
      'buttonText': 'Shop Now',
    },
    {
      'title':      'Summer Sale',
      'subtitle':   'Up to 50% Off Selected Items',
      'image':      'https://images.unsplash.com/photo-1601121141461-9d6647bef0a4?w=800',
      'buttonText': 'Explore',
    },
  ];

  // Dummy products added to replace Cubit state data
  final List<Map<String, dynamic>> _dummyProducts = [
    {
      'name': 'Classic Diamond Ring',
      'image': 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500',
      'price': 1250.00,
    },
    {
      'name': 'Elegant Gold Necklace',
      'image': 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500',
      'price': 850.00,
    },
    {
      'name': 'Luxury Quartz Watch',
      'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=500',
      'price': 2100.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: AppBottomNavWidget(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() => _bottomNavIndex = index);
        
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Top bar ───────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPadding,
                  vertical: AppSizes.md,
                ),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: const Icon(Icons.person, color: AppColors.primary),
                    ),
                    SizedBox(width: AppSizes.sm),
                    // Greeting
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello, Sarah', style: AppTextStyles.caption),
                          Text('Stylo', style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary)),
                        ],
                      ),
                    ),
                    // Bell
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_outlined),
                      color: AppColors.lightTextPrimary,
                    ),
                  ],
                ),
              ),
            ),

            // ── Search bar ────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: const CustomSearchBarWidget(readOnly: true),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),

            // ── Offer banner ──────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: OfferBannerWidget(offers: _dummyOffers),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

            // ── Categories ────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: SectionHeaderWidget(
                  title: 'Categories',
                  actionText: 'See All',
                  onActionTap: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                  itemCount: _categoryIcons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: AppSizes.md),
                      child: CategoryItemWidget(
                        name:       _categoryIcons[index]['name'],
                        icon:       _categoryIcons[index]['icon'],
                        isSelected: _selectedCategory == index,
                        onTap: () => setState(() => _selectedCategory = index),
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

            // ── Featured ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: SectionHeaderWidget(
                  title: 'Featured',
                  actionText: 'View More',
                  onActionTap: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.productCardHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                  itemCount: _dummyProducts.length,
                  itemBuilder: (context, index) {
                    final product = _dummyProducts[index];
                    return Padding(
                      padding: EdgeInsets.only(right: AppSizes.md),
                      child: ProductCardWidget(
                        name:        product['name'],
                        image:       product['image'],
                        price:       product['price'],
                        rating:      4.5,
                        onTap:       () {}, // TODO: navigate to product detail
                        onAddToCart: () {}, // TODO: add to cart
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.lg)),

            // ── Popular Now ───────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                child: SectionHeaderWidget(
                  title: 'Popular Now',
                  actionText: 'Explore',
                  onActionTap: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.md)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppSizes.productCardHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPadding),
                  itemCount: _dummyProducts.length,
                  itemBuilder: (context, index) {
                    final product = _dummyProducts[index];
                    return Padding(
                      padding: EdgeInsets.only(right: AppSizes.md),
                      child: ProductCardWidget(
                        name:        product['name'],
                        image:       product['image'],
                        price:       product['price'],
                        rating:      4.2,
                        onTap:       () {},
                        onAddToCart: () {},
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: AppSizes.xl)),
          ],
        ),
      ),
    );
  }
}