import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/presentation/screens/checkout/checkout_screen.dart';
import 'package:stylo_app/features/categories/presentation/screens/categories/categories_screen.dart';
import 'package:stylo_app/features/home/presentation/screens/home/home_screen.dart';
import 'package:stylo_app/features/profile/presentation/screens/profile/profile_screen.dart';

import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(AppSizes.sm),
          child: const CircleAvatar(
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, color: AppColors.white),
          ),
        ),
        title: Text(
          'Stylo',
          style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.md),
            child: const Icon(
              Icons.notifications_none,
              color: AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavWidget(
        currentIndex: 2,
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
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
                (route) => false,
              );
              break;
            case 2:
              break; // already here
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ──────────────────────────────────────────
            Text('Your Cart', style: AppTextStyles.displayMedium),
            SizedBox(height: AppSizes.xs),
            Text(
              'Review your curated selection',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary,
              ),
            ),
            SizedBox(height: AppSizes.lg),

            // ── Cart item 1 ────────────────────────────────────
            _CartItemCard(
              imagePath: 'build/assets/watchbrand.jpg',
              name: 'Ethereal Silver Watch',
              ref: 'Ref: BQ-2024-SV',
              price: '\$450.00',
              quantity: 1,
            ),
            SizedBox(height: AppSizes.md),

            // ── Cart item 2 ────────────────────────────────────
            _CartItemCard(
              imagePath: 'build/assets/glass.jpg',
              name: 'Gold Frame Optics',
              ref: 'Ref: BQ-2024-GD',
              price: '\$180.00',
              quantity: 2,
            ),
            SizedBox(height: AppSizes.xl),

            // ── Coupon ─────────────────────────────────────────
            Text(
              'HAVE A COUPON?',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.lightTextSecondary,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: AppSizes.sm),
            _CouponField(),

            SizedBox(height: AppSizes.lg),

            // ── Order summary ──────────────────────────────────
            _OrderSummaryCard(
              subtotal: '\$810.00',
              shipping: 'Free',
              total: '\$810.00',
            ),

            SizedBox(height: AppSizes.xl),

            // ── Checkout button ────────────────────────────────
            Container(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                ),
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  shadowColor: AppColors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                child: Text(
                  'Proceed to Checkout',
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),

            SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }
}

// ── Cart item card ────────────────────────────────────────────────────────────
class _CartItemCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String ref;
  final String price;
  final int quantity;

  const _CartItemCard({
    required this.imagePath,
    required this.name,
    required this.ref,
    required this.price,
    required this.quantity,
  });

  @override
  State<_CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<_CartItemCard> {
  late int _qty;

  @override
  void initState() {
    super.initState();
    _qty = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: Image.asset(
              widget.imagePath,
              height: 75,
              width: 75,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 75,
                width: 75,
                color: AppColors.lightBackground,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.md),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(
                  widget.ref,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(widget.price, style: AppTextStyles.price),
              ],
            ),
          ),

          // Delete + Quantity
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.delete_outline, color: AppColors.error),
              ),
              SizedBox(height: AppSizes.md),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: () => setState(() {
                        if (_qty > 1) _qty--;
                      }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.sm),
                      child: Text(
                        '$_qty',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.lightTextPrimary,
                        ),
                      ),
                    ),
                    _QtyButton(
                      icon: Icons.add,
                      onTap: () => setState(() => _qty++),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 10,
        backgroundColor: AppColors.lightSurface,
        child: Icon(icon, size: 14, color: AppColors.primary),
      ),
    );
  }
}

// ── Coupon field ──────────────────────────────────────────────────────────────
class _CouponField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.buttonHeight,
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
      ),
      child: Row(
        children: [
          SizedBox(width: AppSizes.md),
          Expanded(
            child: TextField(
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter code',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ),
          ),
          Container(
            width: 80,
            height: 38,
            margin: EdgeInsets.only(right: AppSizes.sm),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            ),
            child: Center(
              child: Text(
                'Apply',
                style: AppTextStyles.buttonSmall.copyWith(
                  color: AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Order summary card ────────────────────────────────────────────────────────
class _OrderSummaryCard extends StatelessWidget {
  final String subtotal;
  final String shipping;
  final String total;

  const _OrderSummaryCard({
    required this.subtotal,
    required this.shipping,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Order Summary', style: AppTextStyles.headingSmall),
          ),
          SizedBox(height: AppSizes.md),
          _SummaryRow(label: 'Subtotal', value: subtotal),
          SizedBox(height: AppSizes.sm),
          _SummaryRow(label: 'Shipping', value: shipping),
          const Divider(height: 24),
          _SummaryRow(
            label: 'Total',
            value: total,
            bold: true,
            valueColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: bold
              ? AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w700)
              : AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
        ),
        Text(
          value,
          style: bold
              ? AppTextStyles.headingSmall.copyWith(
                  color: valueColor ?? AppColors.lightTextPrimary,
                )
              : AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
