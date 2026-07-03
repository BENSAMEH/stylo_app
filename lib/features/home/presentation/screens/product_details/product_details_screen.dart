import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  final double oldPrice;
  final String category;
  final String description;
  final double rating;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.category,
    required this.description,
    this.rating = 4.5,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavourite = false;
  int  _currentImage = 0;

  // For now one image — replace with a list from API later
  List<String> get _images => [widget.image];

  int get _discountPercent {
    if (widget.oldPrice <= 0) return 0;
    return (((widget.oldPrice - widget.price) / widget.oldPrice) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ── Clean Standard AppBar ───────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Center(
          child: IconButton(icon:Icon(Icons.arrow_back,), 
            onPressed: () => Navigator.pop(context),)
            
          
        ),
        actions: [
          _CircleIconButton(
            icon: Icons.share_outlined,
            onTap: () {},
          ),
          SizedBox(width: AppSizes.sm),
          _CircleIconButton(
            icon: _isFavourite ? Icons.favorite : Icons.favorite_border,
            iconColor: _isFavourite ? AppColors.secondary : AppColors.lightTextPrimary,
            onTap: () => setState(() => _isFavourite = !_isFavourite),
          ),
          SizedBox(width: AppSizes.md),
        ],
      ),
      body: Column(
        children: [
          // ── Scrollable content ─────────────────────────────────
          Expanded(
            child: CustomScrollView(
              slivers: [
                // ── Image carousel ────────────────────────────────
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      // Image
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: PageView.builder(
                          itemCount: _images.length,
                          onPageChanged: (i) => setState(() => _currentImage = i),
                          itemBuilder: (_, i) => Container(padding: EdgeInsets.only(left:  5,right: 5,top: 10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              _images[i],
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: AppColors.lightBackground,
                                child: const Icon(Icons.image_not_supported_outlined,
                                    size: 48, color: AppColors.lightTextSecondary),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Dots indicator (bottom-right of image)
                      if (_images.length > 1)
                        Positioned(
                          bottom: AppSizes.sm,
                          right: AppSizes.md,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.sm, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusFull),
                            ),
                            child: Row(
                              children: List.generate(
                                _images.length,
                                (i) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
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

                      // Single dot shown even with 1 image (matches design)
                      if (_images.length == 1)
                        Positioned(
                          bottom: AppSizes.sm,
                          right: AppSizes.md,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.sm, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusFull),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 16, height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusFull),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 6, height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusFull),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ── Product info ──────────────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppSizes.screenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category label
                        Text(
                          widget.category.toUpperCase(),
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: AppSizes.xs),

                        // Product name
                        Text(widget.name, style: AppTextStyles.headingLarge),
                        SizedBox(height: AppSizes.md),

                        // Price row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\$${widget.price.toStringAsFixed(0)}',
                              style: AppTextStyles.price.copyWith(fontSize: 22),
                            ),
                            SizedBox(width: AppSizes.sm),
                            if (widget.oldPrice > widget.price)
                              Text(
                                '\$${widget.oldPrice.toStringAsFixed(0)}',
                                style: AppTextStyles.priceOld,
                              ),
                            SizedBox(width: AppSizes.sm),
                            if (_discountPercent > 0)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSizes.sm, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusFull),
                                ),
                                child: Text(
                                  'Save $_discountPercent%',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: AppSizes.lg),

                        // Description header
                        Text('Description', style: AppTextStyles.headingSmall),
                        SizedBox(height: AppSizes.sm),

                        // Description body
                        Text(
                          widget.description,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightTextSecondary,
                            height: 1.6,
                          ),
                        ),

                        SizedBox(height: AppSizes.xl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Add to Cart button (pinned at bottom) ──────────────
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
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: wire to CartCubit.addToCart()
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.name} added to cart!'),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMd)),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                textStyle: AppTextStyles.buttonLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable circle icon button ──────────────────────────────────────────────
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: iconColor ?? AppColors.lightTextPrimary,
        ),
      ),
    );
  }
}