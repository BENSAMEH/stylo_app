import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/presentation/screens/order_success/order_success_screen.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedDelivery = 0; // 0 = express, 1 = standard

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.lightTextPrimary),
        ),
        title: Text('Checkout', style: AppTextStyles.headingSmall),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Shipping address ───────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Address', style: AppTextStyles.headingSmall),
                Text('Edit',
                    style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary)),
              ],
            ),
            SizedBox(height: AppSizes.md),
            Container(
              padding: EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color:        AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(Icons.location_on,
                        color: AppColors.primary),
                  ),
                  SizedBox(width: AppSizes.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Home', style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.lightTextPrimary,
                          fontWeight: FontWeight.w700)),
                      SizedBox(height: AppSizes.xs),
                      Text('1224 Fifth Avenue, Upper East',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.lightTextSecondary)),
                      Text('Side',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.lightTextSecondary)),
                      Text('New York, NY 10029, USA',
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.lightTextSecondary)),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Delivery method ────────────────────────────────
            Text('Delivery Method', style: AppTextStyles.headingSmall),
            SizedBox(height: AppSizes.md),

            _DeliveryOption(
              icon:       Icons.local_shipping,
              title:      'Express Delivery',
              subtitle:   '1-2 BUSINESS DAYS',
              price:      '\$15.00',
              isSelected: _selectedDelivery == 0,
              onTap:      () => setState(() => _selectedDelivery = 0),
            ),
            SizedBox(height: AppSizes.md),

            _DeliveryOption(
              icon:       Icons.circle_outlined,
              title:      'Standard Delivery',
              subtitle:   '5-7 BUSINESS DAYS',
              price:      'Free',
              isSelected: _selectedDelivery == 1,
              onTap:      () => setState(() => _selectedDelivery = 1),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Promo code ─────────────────────────────────────
            Text('Promo Code',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.lightTextSecondary)),
            SizedBox(height: AppSizes.sm),
            Container(
              height: AppSizes.buttonHeight,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
              decoration: BoxDecoration(
                color:        AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        border:   InputBorder.none,
                        hintText: 'Promo Code',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.lightTextSecondary),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Apply',
                        style: AppTextStyles.bodySmall.copyWith(
                            color:      AppColors.primary,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Order summary ──────────────────────────────────
            Container(
              padding: EdgeInsets.all(AppSizes.lg),
              decoration: BoxDecoration(
                color:        AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER SUMMARY',
                    style: AppTextStyles.caption.copyWith(
                      color:         AppColors.lightTextSecondary,
                      fontWeight:    FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: AppSizes.lg),
                  _CheckoutRow(label: 'Subtotal (3 items)', value: '\$1,420.00'),
                  SizedBox(height: AppSizes.sm),
                  _CheckoutRow(label: 'Shipping', value: '\$15.00'),
                  SizedBox(height: AppSizes.sm),
                  _CheckoutRow(
                    label:      'Discount (STYLO10)',
                    value:      '-\$142.00',
                    color:      AppColors.primary,
                  ),
                  const Divider(height: 28),
                  _CheckoutRow(
                    label:      'Total',
                    value:      '\$1,293.00',
                    color:      AppColors.primary,
                    bold:       true,
                    largeFontSize: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Place order button ─────────────────────────────
            Container(
              width:  double.infinity,
              height: AppSizes.buttonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                ),
              ),
              child: ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderSuccessScreen()),
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  shadowColor:     AppColors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Place Order', style: AppTextStyles.buttonLarge),
                    SizedBox(width: AppSizes.sm),
                    const Icon(Icons.arrow_forward, color: AppColors.white),
                  ],
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

class _DeliveryOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const _DeliveryOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color:        AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.lightTextSecondary),
                    SizedBox(width: AppSizes.sm),
                    Text(title,
                        style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.lightTextPrimary,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Text(price, style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: AppSizes.xs),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(subtitle,
                  style: AppTextStyles.caption.copyWith(
                      color: AppColors.lightTextSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckoutRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final bool bold;
  final bool largeFontSize;

  const _CheckoutRow({
    required this.label,
    required this.value,
    this.color,
    this.bold          = false,
    this.largeFontSize = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = largeFontSize
        ? AppTextStyles.headingSmall.copyWith(
            color: color ?? AppColors.lightTextPrimary)
        : AppTextStyles.bodyMedium.copyWith(
            color:      color ?? AppColors.lightTextSecondary,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}