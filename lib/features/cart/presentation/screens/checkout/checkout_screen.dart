import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/di/injection_container.dart';

import 'package:stylo_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:stylo_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:stylo_app/features/cart/presentation/cubit/checkout_cubit.dart';
import 'package:stylo_app/features/cart/presentation/cubit/checkout_state.dart';
import 'package:stylo_app/features/cart/presentation/screens/order_success/order_success_screen.dart';
import 'package:stylo_app/features/profile/data/models/address_model.dart';
import 'package:stylo_app/features/profile/data/repositories/address_repository_impl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedDelivery = 0; // 0 = express, 1 = standard

  // ✅ تم التأكد فعليًا: "CashOnDelivery" هي القيمة الصحيحة اللي
  // قبلها السيرفر (اتأكدت بالتجربة المباشرة عبر الـ debug console)
  String _selectedPaymentMethod = 'CashOnDelivery';

  final AddressRepositoryImpl _addressRepository =
    sl<AddressRepositoryImpl>();

  List<AddressModel> _addresses = [];
  AddressModel? _selectedAddress;
  bool _loadingAddresses = true;
  String? _addressError;

  @override
  void initState() {
    super.initState();
    _fetchAddresses();
  }

  Future<void> _fetchAddresses() async {
    setState(() {
      _loadingAddresses = true;
      _addressError = null;
    });

    try {
      final addresses = await _addressRepository.getAddresses();

      if (!mounted) return;
      setState(() {
        _addresses = addresses;
        _selectedAddress = addresses.isNotEmpty ? addresses.first : null;
        _loadingAddresses = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingAddresses = false;
        _addressError = e.toString();
      });
    }
  }

  void _showSnack(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),
    );
  }

  void _onPlaceOrder() {
    if (_selectedAddress == null) {
      _showSnack('Please select a shipping address', AppColors.error);
      return;
    }

    context.read<CheckoutCubit>().checkout(
      shippingAddressId: _selectedAddress!.id,
      paymentMethod: _selectedPaymentMethod,
    );
  }

  void _openAddAddressSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddAddressSheet(
        onAdded: () {
          Navigator.pop(context);
          _fetchAddresses();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;
    final cart = cartState is CartLoaded ? cartState.cart : null;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => OrderSuccessScreen(response: state.response),
            ),
            (route) => false,
          );
        } else if (state is CheckoutFailure) {
          _showSnack(state.message, AppColors.error);
        }
      },
      builder: (context, checkoutState) {
        final isPlacingOrder = checkoutState is CheckoutLoading;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon:  Icon(
                Icons.arrow_back,
                color: AppColors.textPrimary(context),
              ),
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
                    if (_addresses.isNotEmpty)
                      GestureDetector(
                        onTap: () => _showAddressPicker(context),
                        child: Text(
                          'Change',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: AppSizes.md),
                _buildAddressCard(),

                SizedBox(height: AppSizes.xl),

                // ── Delivery method ────────────────────────────────
                Text('Delivery Method', style: AppTextStyles.headingSmall),
                SizedBox(height: AppSizes.md),

                _DeliveryOption(
                  icon: Icons.local_shipping,
                  title: 'Express Delivery',
                  subtitle: '1-2 BUSINESS DAYS',
                  price: '\$15.00',
                  isSelected: _selectedDelivery == 0,
                  onTap: () => setState(() => _selectedDelivery = 0),
                ),
                SizedBox(height: AppSizes.md),

                _DeliveryOption(
                  icon: Icons.circle_outlined,
                  title: 'Standard Delivery',
                  subtitle: '5-7 BUSINESS DAYS',
                  price: 'Free',
                  isSelected: _selectedDelivery == 1,
                  onTap: () => setState(() => _selectedDelivery = 1),
                ),

                SizedBox(height: AppSizes.xl),

                // ── Payment method ──────────────────────────────────
                Text('Payment Method', style: AppTextStyles.headingSmall),
                SizedBox(height: AppSizes.md),
                Row(
                  children: [
                    Expanded(
                      child: _PaymentOption(
                        label: 'Cash on Delivery',
                        // ✅ القيمة دي مؤكدة 100% وشغالة فعليًا
                        isSelected: _selectedPaymentMethod == 'CashOnDelivery',
                        onTap: () => setState(
                          () => _selectedPaymentMethod = 'CashOnDelivery',
                        ),
                      ),
                    ),
                    SizedBox(width: AppSizes.md),
                    Expanded(
                      child: _PaymentOption(
                        label: 'Card',
                        // ⚠️ لسه غير مؤكدة 100% — لم تُختبر فعليًا.
                        // "Card" مجرد أقرب افتراض بنفس نمط PascalCase
                        // زي "CashOnDelivery". لو ظهر خطأ "Invalid
                        // payment method" عند اختيارها، كرر نفس أسلوب
                        // التجربة (جرب "CreditCard", "Paymob"... إلخ)
                        isSelected: _selectedPaymentMethod == 'Card',
                        onTap: () =>
                            setState(() => _selectedPaymentMethod = 'Card'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.xl),

                // ── Promo code ─────────────────────────────────────
                Text(
                  'Promo Code',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),
                SizedBox(height: AppSizes.sm),
                Container(
                  height: AppSizes.buttonHeight,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface(context),
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Promo Code',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Apply',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: AppSizes.xl),

                // ── Order summary ────────────────────────────────
                Container(
                  padding: EdgeInsets.all(AppSizes.lg),
                  decoration: BoxDecoration(
                    color: AppColors.surface(context),
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER SUMMARY',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary(context),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: AppSizes.lg),
                      if (cart == null)
                        Text(
                          'Loading cart...',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary(context),
                          ),
                        )
                      else ...[
                        _CheckoutRow(
                          label: 'Subtotal (${cart.items.length} items)',
                          value: '\$${cart.subtotal.toStringAsFixed(2)}',
                        ),
                        SizedBox(height: AppSizes.sm),
                        _CheckoutRow(
                          label: 'Shipping',
                          value: _selectedDelivery == 0 ? '\$15.00' : 'Free',
                        ),
                        if (cart.totalDiscount > 0) ...[
                          SizedBox(height: AppSizes.sm),
                          _CheckoutRow(
                            label: 'Discount',
                            value:
                                '-\$${cart.totalDiscount.toStringAsFixed(2)}',
                            color: AppColors.primary,
                          ),
                        ],
                        const Divider(height: 28),
                        _CheckoutRow(
                          label: 'Total',
                          value:
                              '\$${(cart.totalPrice + (_selectedDelivery == 0 ? 15 : 0)).toStringAsFixed(2)}',
                          color: AppColors.primary,
                          bold: true,
                          largeFontSize: true,
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: AppSizes.xl),

                // ── Place order button ─────────────────────────────
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
                    onPressed: isPlacingOrder ? null : _onPlaceOrder,
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
                    child: isPlacingOrder
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Place Order',
                                style: AppTextStyles.buttonLarge,
                              ),
                              SizedBox(width: AppSizes.sm),
                              const Icon(
                                Icons.arrow_forward,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                  ),
                ),

                SizedBox(height: AppSizes.lg),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressCard() {
    if (_loadingAddresses) {
      return Container(
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_addressError != null) {
      return Container(
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Failed to load addresses',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
            ),
            SizedBox(height: AppSizes.sm),
            TextButton(onPressed: _fetchAddresses, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (_addresses.isEmpty) {
      return Container(
        padding: EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No saved addresses. Please add one first.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary(context),
              ),
            ),
            SizedBox(height: AppSizes.sm),
            TextButton.icon(
              onPressed: _openAddAddressSheet,
              icon: const Icon(Icons.add, color: AppColors.primary),
              label: Text(
                'Add Address',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final address = _selectedAddress!;

    return Container(
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.surface(context),
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.location_on, color: AppColors.primary),
          ),
          SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.displayLine1,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(
                  address.displayLine2,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),
                if (address.notes.isNotEmpty)
                  Text(
                    address.notes,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          ..._addresses.map((address) {
            return ListTile(
              leading: const Icon(Icons.location_on, color: AppColors.primary),
              title: Text(address.displayLine1),
              subtitle: Text(address.displayLine2),
              onTap: () {
                setState(() => _selectedAddress = address);
                Navigator.pop(context);
              },
            );
          }),
          ListTile(
            leading: const Icon(Icons.add, color: AppColors.primary),
            title: Text(
              'Add New Address',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              _openAddAddressSheet();
            },
          ),
        ],
      ),
    );
  }
}

// ── Bottom Sheet لإضافة عنوان جديد ─────────────────────────────────
class _AddAddressSheet extends StatefulWidget {
  final VoidCallback onAdded;
  const _AddAddressSheet({required this.onAdded});

  @override
  State<_AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<_AddAddressSheet> {
  final _formKey = GlobalKey<FormState>();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  final AddressRepositoryImpl _repository =
    sl<AddressRepositoryImpl>();
  bool _isSaving = false;

  @override
  void dispose() {
    _stateController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _apartmentController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      await _repository.addAddress(
        AddressModel(
          id: '',
          state: _stateController.text,
          city: _cityController.text,
          street: _streetController.text,
          apartment: _apartmentController.text,
          phoneNumber: _phoneController.text,
          notes: _notesController.text,
        ),
      );

      if (!mounted) return;
      widget.onAdded();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add address: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(AppSizes.lg),
        decoration:  BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: AppSizes.md),
                    decoration: BoxDecoration(
                      color: AppColors.divider(context),
                      borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                    ),
                  ),
                ),
                Text('Add New Address', style: AppTextStyles.headingSmall),
                SizedBox(height: AppSizes.lg),

                _field('City', _cityController),
                SizedBox(height: AppSizes.sm),
                _field('State', _stateController),
                SizedBox(height: AppSizes.sm),
                _field('Street', _streetController),
                SizedBox(height: AppSizes.sm),
                _field('Apartment', _apartmentController, required: false),
                SizedBox(height: AppSizes.sm),
                _field(
                  'Phone Number',
                  _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: AppSizes.sm),
                _field('Notes', _notesController, required: false, maxLines: 2),

                SizedBox(height: AppSizes.lg),

                SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusFull,
                        ),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : Text(
                            'Save Address',
                            style: AppTextStyles.buttonLarge,
                          ),
                  ),
                ),
                SizedBox(height: AppSizes.md),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool required = true,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppColors.background(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          borderSide: BorderSide.none,
        ),
      ),
      validator: required
          ? (v) => (v == null || v.isEmpty) ? 'Required' : null
          : null,
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
          color: AppColors.surface(context),
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
                    Icon(
                      icon,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary(context),
                    ),
                    SizedBox(width: AppSizes.sm),
                    Text(
                      title,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textPrimary(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(
                  price,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.xs),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSizes.md),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface(context),
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? AppColors.primary : AppColors.textPrimary(context),
            fontWeight: FontWeight.w700,
          ),
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
    this.bold = false,
    this.largeFontSize = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = largeFontSize
        ? AppTextStyles.headingSmall.copyWith(
            color: color ?? AppColors.textPrimary(context),
          )
        : AppTextStyles.bodyMedium.copyWith(
            color: color ?? AppColors.textSecondary(context),
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
