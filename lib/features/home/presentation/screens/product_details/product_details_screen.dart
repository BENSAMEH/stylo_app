import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/di/injection_container.dart';
import 'package:stylo_app/features/home/data/models/review_model.dart';
import 'package:stylo_app/features/home/presentation/cubit/product_detail_cubit.dart';
import 'package:stylo_app/features/home/presentation/cubit/product_detail_state.dart';
import 'package:stylo_app/features/home/presentation/widgets/circle_icon_button.dart';

// ── Entry point ───────────────────────────────────────────────────────────────
class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductDetailCubit>()..loadProduct(productId),
      child: const _ProductDetailView(),
    );
  }
}

// ── Actual view ───────────────────────────────────────────────────────────────
class _ProductDetailView extends StatefulWidget {
  const _ProductDetailView();

  @override
  State<_ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<_ProductDetailView> {
  bool _isFavourite  = false;
  int  _currentImage = 0;

  int _discountPercent(double price, double oldPrice) {
    if (oldPrice <= price) return 0;
    return (((oldPrice - price) / oldPrice) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {

        // ── Loading ──────────────────────────────────────────
        if (state is ProductDetailLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ── Error ────────────────────────────────────────────
        if (state is ProductDetailError) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: AppColors.lightTextSecondary),
                  SizedBox(height: AppSizes.md),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightTextSecondary),
                  ),
                  SizedBox(height: AppSizes.lg),
                  ElevatedButton(
                    onPressed: () => context
                        .read<ProductDetailCubit>()
                        .loadProduct(
                        (context.widget as _ProductDetailView).hashCode),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Success ──────────────────────────────────────────
        if (state is ProductDetailSuccess) {
          final product  = state.product;
          final reviews  = state.reviews;
          final images   = [product.imageUrl];
          final discount = _discountPercent(product.price, product.price * 1.25);

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            // ── AppBar ──────────────────────────────────────
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                CircleIconButton(
                  icon: Icons.share_outlined,
                  onTap: () {},
                ),
                SizedBox(width: AppSizes.sm),
                CircleIconButton(
                  icon: _isFavourite ? Icons.favorite : Icons.favorite_border,
                  iconColor: _isFavourite
                      ? AppColors.secondary
                      : AppColors.lightTextPrimary,
                  onTap: () => setState(() => _isFavourite = !_isFavourite),
                ),
                SizedBox(width: AppSizes.md),
              ],
            ),

            body: Column(
              children: [

                // ── Scrollable content ───────────────────────
                Expanded(
                  child: CustomScrollView(
                    slivers: [

                      // ── Image carousel ─────────────────────
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: PageView.builder(
                                itemCount: images.length,
                                onPageChanged: (i) =>
                                    setState(() => _currentImage = i),
                                itemBuilder: (_, i) => Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSizes.sm,
                                    vertical:   AppSizes.sm,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusLg),
                                    child: Image.network(
                                      images[i],
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: AppColors.lightBackground,
                                        child: const Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 48,
                                          color: AppColors.lightTextSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Dots indicator
                            Positioned(
                              bottom: AppSizes.sm,
                              right:  AppSizes.md,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSizes.sm, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusFull),
                                ),
                                child: Row(
                                  children: List.generate(
                                    images.length < 2 ? 2 : images.length,
                                        (i) => AnimatedContainer(
                                      duration:
                                      const Duration(milliseconds: 250),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      width: _currentImage == i ? 16 : 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: _currentImage == i
                                            ? AppColors.white
                                            : AppColors.white.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.radiusFull),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── Product info ────────────────────────
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(AppSizes.screenPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Category
                              Text(
                                'Fine Jewelry',
                                style: AppTextStyles.caption.copyWith(
                                  color:         AppColors.primary,
                                  fontWeight:    FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: AppSizes.xs),

                              // Name
                              Text(product.name,
                                  style: AppTextStyles.headingLarge),
                              SizedBox(height: AppSizes.md),

                              // Price row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${product.price.toStringAsFixed(0)}',
                                    style: AppTextStyles.price
                                        .copyWith(fontSize: 22),
                                  ),
                                  SizedBox(width: AppSizes.sm),
                                  Text(
                                    '\$${(product.price * 1.25).toStringAsFixed(0)}',
                                    style: AppTextStyles.priceOld,
                                  ),
                                  SizedBox(width: AppSizes.sm),
                                  if (discount > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppSizes.sm, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.radiusFull),
                                      ),
                                      child: Text(
                                        'Save $discount%',
                                        style: AppTextStyles.caption.copyWith(
                                          color:      AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: AppSizes.lg),

                              // Description
                              Text('Description',
                                  style: AppTextStyles.headingSmall),
                              SizedBox(height: AppSizes.sm),
                              Text(
                                product.description.isNotEmpty
                                    ? product.description
                                    : 'A beautiful handcrafted piece made with premium materials.',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color:  AppColors.lightTextSecondary,
                                  height: 1.6,
                                ),
                              ),

                              SizedBox(height: AppSizes.xl),

                              // ── Reviews section ─────────────
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Reviews',
                                      style: AppTextStyles.headingSmall),
                                  Text(
                                    '${reviews.length} reviews',
                                    style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.lightTextSecondary),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppSizes.md),

                              reviews.isEmpty
                                  ? Center(
                                child: Text(
                                  'No reviews yet',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.lightTextSecondary),
                                ),
                              )
                                  : ListView.separated(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: reviews.length,
                                separatorBuilder: (_, __) => Divider(
                                  color:  AppColors.lightDivider,
                                  height: AppSizes.lg,
                                ),
                                itemBuilder: (_, i) =>
                                    _ReviewItem(review: reviews[i]),
                              ),

                              SizedBox(height: AppSizes.xl),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Add to Cart button ───────────────────────
                Container(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    AppSizes.sm,
                    AppSizes.screenPadding,
                    AppSizes.lg,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color:      Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset:     const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: wire to CartCubit.addToCart(productId, 1)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart!'),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(AppSizes.radiusMd),
                          ),
                        ),
                      );
                    },
                    icon:  const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(AppSizes.radiusFull),
                      ),
                      textStyle: AppTextStyles.buttonLarge,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }
}

// ── Single review item ────────────────────────────────────────────────────────
class _ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const _ReviewItem({required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        CircleAvatar(
          radius:          20,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Text(
            review.userName.isNotEmpty
                ? review.userName[0].toUpperCase()
                : '?',
            style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
          ),
        ),
        SizedBox(width: AppSizes.sm),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name + stars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review.userName,
                    style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < review.rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        size:  14,
                        color: AppColors.starColor,
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.xs),

              // Comment
              Text(
                review.comment,
                style: AppTextStyles.bodySmall.copyWith(
                  color:  AppColors.lightTextSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}