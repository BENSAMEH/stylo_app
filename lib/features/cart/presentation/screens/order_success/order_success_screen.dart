import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/home/presentation/screens/home/home_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Stylo',
          style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          children: [

            SizedBox(height: AppSizes.lg),

            // ── Success icon ───────────────────────────────────
            Container(
              height: 80,
              width:  80,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: AppColors.white, size: 45),
            ),

            SizedBox(height: AppSizes.lg),

            // ── Title ──────────────────────────────────────────
            Text('Order Confirmed', style: AppTextStyles.displayMedium),
            SizedBox(height: AppSizes.md),

            Text(
              'Thank you for choosing Stylo. Your luxury\naccessories are being prepared.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary),
            ),

            SizedBox(height: AppSizes.xl),

            // ── Order details card ─────────────────────────────
            Container(
              width:   double.infinity,
              padding: EdgeInsets.all(AppSizes.lg),
              decoration: BoxDecoration(
                color:        AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ORDER ID',
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.lightTextSecondary)),
                  SizedBox(height: AppSizes.xs),
                  Text('#STY-882941-X', style: AppTextStyles.headingLarge),
                  SizedBox(height: AppSizes.md),
                  Divider(color: AppColors.lightDivider),
                  SizedBox(height: AppSizes.md),
                  Text('ESTIMATED DELIVERY',
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.lightTextSecondary)),
                  SizedBox(height: AppSizes.xs),
                  Text('Oct 24, 2025', style: AppTextStyles.headingLarge),
                ],
              ),
            ),

            SizedBox(height: AppSizes.lg),

            // ── Email note ─────────────────────────────────────
            Text(
              'A confirmation email has been sent to your\nregistered email address.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightTextSecondary),
            ),

            SizedBox(height: AppSizes.lg),

            // ── Summary rows ───────────────────────────────────
            _ConfirmRow(label: 'Items',    value: '3 luxury pieces'),
            SizedBox(height: AppSizes.md),
            _ConfirmRow(label: 'Shipping', value: 'Complimentary Express'),
            const Divider(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: AppTextStyles.headingMedium),
                Text('\$1,240.00',
                    style: AppTextStyles.headingMedium.copyWith(
                        color: AppColors.primary)),
              ],
            ),

            SizedBox(height: AppSizes.xxl),

            // ── Continue shopping button ───────────────────────
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
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
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
                    Text('Continue Shopping', style: AppTextStyles.buttonLarge),
                    SizedBox(width: AppSizes.sm),
                    const Icon(Icons.arrow_forward, color: AppColors.white),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSizes.md),

            // ── View receipt button ────────────────────────────
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, AppSizes.buttonHeight),
                side: const BorderSide(color: AppColors.lightDivider),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.receipt_long_outlined,
                      color: AppColors.lightTextSecondary),
                  SizedBox(width: AppSizes.sm),
                  Text('View Receipt',
                      style: AppTextStyles.buttonLarge.copyWith(
                          color: AppColors.lightTextSecondary)),
                ],
              ),
            ),

            SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final String label;
  final String value;
  const _ConfirmRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary)),
        Text(value,
            style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}