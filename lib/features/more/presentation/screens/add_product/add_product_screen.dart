import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/more/presentation/widgets/add_product_app_bar_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/add_product_header_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/labeled_dropdown_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/labeled_text_field_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/price_quantity_row_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/product_image_upload_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/save_product_button_widget.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey          = GlobalKey<FormState>();
  final _nameController   = TextEditingController();
  final _descController   = TextEditingController();
  final _priceController  = TextEditingController();
  final _stockController  = TextEditingController();

  String? _selectedCategory;
  // ignore: unused_field
  File?   _selectedImage;
  bool    _isLoading = false;

  final List<String> _categories = [
    'Rings',
    'Necklaces',
    'Earrings',
    'Watches',
    'Bracelets',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a category'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Product saved successfully!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd)),
        ),
      );
      Navigator.pop(context);
    });
  }

  void _onDiscard() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        title: Text('Discard Draft?', style: AppTextStyles.headingSmall),
        content: Text(
          'All entered data will be lost.',
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.lightTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back
            },
            child: Text('Discard',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AddProductAppBarWidget(onBack: () => Navigator.pop(context)),
      bottomNavigationBar: AppBottomNavWidget(
        currentIndex: 3,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Header ───────────────────────────────────────
              const AddProductHeaderWidget(),
              SizedBox(height: AppSizes.lg),

              // ── Image upload ─────────────────────────────────
              ProductImageUploadWidget(
                onImageSelected: (image) => _selectedImage = image,
              ),
              SizedBox(height: AppSizes.lg),

              // ── Product name ─────────────────────────────────
              LabeledTextFieldWidget(
                label:      'Product Name',
                hint:       'e.g. Royal Chronograph Silver',
                controller: _nameController,
                validator:  (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: AppSizes.md),

              // ── Description ───────────────────────────────────
              LabeledTextFieldWidget(
                label:      'Description',
                hint:       'Describe the craftsmanship, materials, and unique features...',
                controller: _descController,
                maxLines:   4,
                validator:  (v) => (v == null || v.isEmpty) ? 'Required' : null,
              ),
              SizedBox(height: AppSizes.md),

              // ── Category dropdown ─────────────────────────────
              LabeledDropdownWidget(
                label:     'Category',
                hint:      'Select category',
                value:     _selectedCategory,
                items:     _categories,
                onChanged: (val) => setState(() => _selectedCategory = val),
              ),
              SizedBox(height: AppSizes.md),

              // ── Price + Quantity ──────────────────────────────
              PriceQuantityRowWidget(
                priceController:    _priceController,
                quantityController: _stockController,
              ),
              SizedBox(height: AppSizes.xl),

              // ── Save / Discard ────────────────────────────────
              SaveProductButtonWidget(
                onSave:    _onSave,
                onDiscard: _onDiscard,
                isLoading: _isLoading,
              ),

              SizedBox(height: AppSizes.lg),
            ],
          ),
        ),
      ),
    );
  }
}