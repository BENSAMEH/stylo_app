import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';


class ProductCardWidget extends StatefulWidget {
  final String  name;
  final String  image;
  final double  price;
  final double  rating;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCardWidget({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: AppSizes.productCardWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image + Heart ─────────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.cardRadius)),
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    height: AppSizes.productImageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.lightBackground,
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.lightBackground,
                      child: const Icon(Icons.image_not_supported_outlined, color: AppColors.lightTextSecondary),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSizes.sm,
                  right: AppSizes.sm,
                  child: GestureDetector(
                    onTap: () => setState(() => _isFavourite = !_isFavourite),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavourite ? AppColors.secondary : AppColors.lightTextSecondary,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Info ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.all(AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: AppTextStyles.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.starColor, size: 12),
                      SizedBox(width: 2),
                      Text(
                        widget.rating.toStringAsFixed(1),
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.xs),
                  // Price + Cart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price,
                      ),
                      GestureDetector(
                        onTap: widget.onAddToCart,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.shopping_bag_outlined, color: AppColors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}