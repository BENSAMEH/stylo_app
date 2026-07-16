import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/data/models/checkout_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/routing/navigation_cubit.dart';
import 'package:stylo_app/features/home/presentation/screens/main_layout_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  // 🆕 بياخد الـ response الحقيقي الراجع من CheckoutCubit بدل ما يكون
  // الملف كله بيانات وهمية ثابتة
  final CheckoutResponseModel response;

  const OrderSuccessScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      appBar: AppBar(
        backgroundColor: AppColors.surface(context),
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
              width: 80,
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

            // 🔧 بقت بتعرض رسالة السيرفر الحقيقية بدل نص ثابت
            Text(
              response.message.isNotEmpty
                  ? response.message
                  : 'Thank you for choosing Stylo. Your luxury\naccessories are being prepared.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary(context),
              ),
            ),

            SizedBox(height: AppSizes.xl),

            // 🔧 لو السيرفر رجع رابط دفع (لسه مطلوب يكمل الدفع أونلاين)،
            // نوريه للمستخدم بدل ما نخفي المعلومة دي
            if (response.unifiedCheckoutUrl != null &&
                response.unifiedCheckoutUrl!.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete your payment',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      response.unifiedCheckoutUrl!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.xl),
            ],

            SizedBox(height: AppSizes.xxl),

            // ── Continue shopping button ───────────────────────
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
                onPressed: () {
                  context.read<NavigationCubit>().setTab(0);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.transparent,
                  shadowColor: AppColors.transparent,
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

            SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }
}
