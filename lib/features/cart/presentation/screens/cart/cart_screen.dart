import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/cart/data/models/cart_item_model.dart';
import 'package:stylo_app/features/cart/data/models/update_cart_request_model.dart';
import 'package:stylo_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:stylo_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:stylo_app/features/cart/presentation/screens/checkout/checkout_screen.dart';
import 'package:stylo_app/features/cart/presentation/screens/empty_cart/empty_cart_screen.dart';
import 'package:stylo_app/features/categories/presentation/screens/categories/categories_screen.dart';
import 'package:stylo_app/features/home/presentation/screens/home/home_screen.dart';
import 'package:stylo_app/features/profile/presentation/screens/profile/profile_screen.dart';

import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // لازم نجيب الكارت من السيرفر لما الشاشة تفتح
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
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
            child:  Icon(
              Icons.notifications_none,
               color: Theme.of(context).iconTheme.color,
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
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          // ── Loading ──────────────────────────────────────────
          if (state is CartInitial || state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Error (مع Retry) ─────────────────────────────────
          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Failed to load cart',
                    style: AppTextStyles.headingSmall,
                  ),
                  SizedBox(height: AppSizes.sm),
                  TextButton(
                    onPressed: () => context.read<CartCubit>().getCart(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // ── Loaded ───────────────────────────────────────────
          final cart = (state as CartLoaded).cart;

          if (cart.items.isEmpty) {
            return const EmptyCartContent();

          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Title ──────────────────────────────────────
                Text('Your Cart', style: AppTextStyles.displayMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color,)),
                SizedBox(height: AppSizes.xs),
                Text(
                  'Review your curated selection',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: AppSizes.lg),

                // ── Cart items من الـ API ────────────────────────
                for (final item in cart.items) ...[
                  _CartItemCard(
                    item: item,
                    onIncrement: () => context.read<CartCubit>().updateItem(
                      item.itemId,
                      UpdateCartRequestModel(quantity: item.quantity + 1),
                    ),
                    onDecrement: item.quantity > 1
                        ? () => context.read<CartCubit>().updateItem(
                            item.itemId,
                            UpdateCartRequestModel(quantity: item.quantity - 1),
                          )
                        : null,
                    onDelete: () =>
                        context.read<CartCubit>().deleteItem(item.itemId),
                  ),
                  SizedBox(height: AppSizes.md),
                ],

                SizedBox(height: AppSizes.lg),

                // ── Coupon ───────────────────────────────────────
                Text(
                  'HAVE A COUPON?',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary(context),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: AppSizes.sm),
                _CouponField(),

                SizedBox(height: AppSizes.lg),

                // ── Order summary من الـ API ─────────────────────
                _OrderSummaryCard(
                  subtotal: '\$${cart.subtotal.toStringAsFixed(2)}',
                  shipping: 'Free',
                  total: '\$${cart.totalPrice.toStringAsFixed(2)}',
                ),

                SizedBox(height: AppSizes.xl),

                // ── Checkout button ──────────────────────────────
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
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusFull,
                        ),
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
          );
        },
      ),
    );
  }
}

// ── Cart item card ──────────────────────────────────────────────────────
class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback onDelete;

  const _CartItemCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            child: Image.network(
              item.productCoverUrl,
              height: 75,
              width: 75,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 75,
                width: 75,
                color: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: theme.iconTheme.color?.withOpacity(.6),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: theme.textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(
                  'Qty: ${item.quantity}',
                  style: AppTextStyles.caption.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(.7),
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
                  style: AppTextStyles.price,
                ),
              ],
            ),
          ),

          Column(
            children: [
              GestureDetector(
                onTap: onDelete,
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                ),
              ),
              SizedBox(height: AppSizes.md),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.sm,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
                child: Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: onDecrement,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    _QtyButton(
                      icon: Icons.add,
                      onTap: onIncrement,
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
  final VoidCallback? onTap;

  const _QtyButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 10,
        backgroundColor: theme.cardColor,
        child: Icon(
          icon,
          size: 14,
          color: onTap == null
              ? theme.disabledColor
              : AppColors.primary,
        ),
      ),
    );
  }
}

class _CouponField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSizes.buttonHeight,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(
          AppSizes.radiusFull,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: AppSizes.md),
          Expanded(
            child: TextField(
              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter code',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(.6),
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
              borderRadius: BorderRadius.circular(
                AppSizes.radiusFull,
              ),
            ),
            child: Center(
              child: Text(
                'Apply',
                style: AppTextStyles.buttonSmall.copyWith(
                  color: theme.colorScheme.onSecondary,
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
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(
          AppSizes.radiusLg,
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: AppTextStyles.headingSmall.copyWith(
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ),
          SizedBox(height: AppSizes.md),

          _SummaryRow(
            label: 'Subtotal',
            value: subtotal,
          ),

          SizedBox(height: AppSizes.sm),

          _SummaryRow(
            label: 'Shipping',
            value: shipping,
          ),

          Divider(
            height: 24,
            color: theme.dividerColor,
          ),

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
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: bold
              ? AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.textTheme.bodyLarge?.color,
                )
              : AppTextStyles.bodyMedium.copyWith(
                  color: theme.textTheme.bodySmall?.color
                      ?.withOpacity(.7),
                ),
        ),
        Text(
          value,
          style: bold
              ? AppTextStyles.headingSmall.copyWith(
                  color: valueColor ??
                      theme.textTheme.bodyLarge?.color,
                )
              : AppTextStyles.bodyMedium.copyWith(
                  color: theme.textTheme.bodyLarge?.color,
                ),
        ),
      ],
    );
  }
}