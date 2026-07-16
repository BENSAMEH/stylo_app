import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/data/repositories/auth_repository.dart';
import 'package:stylo_app/features/more/models/add_product_request_model.dart';
import 'package:stylo_app/features/more/presentation/cubit/add_product_cubit.dart';
import 'package:stylo_app/features/more/presentation/cubit/add_product_state.dart';
import 'package:stylo_app/features/more/presentation/widgets/add_product_app_bar_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/add_product_header_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/labeled_dropdown_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/labeled_text_field_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/price_quantity_row_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/product_image_upload_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/save_product_button_widget.dart';
import 'package:stylo_app/features/more/repositories/add_product_repository.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  final AddProductRepository _repository = AddProductRepository();
  // 🆕 محتاجينه عشان نجيب بيانات اليوزر المسجل دخول (userId الحقيقي)
  final AuthRepository _authRepository = AuthRepository();

  String? _selectedCategoryName;
  File? _selectedImage;

  // اسم الكاتيجوري -> الـ id الحقيقي (GUID) الجاي من السيرفر
  Map<String, String> _categoriesMap = {};
  bool _loadingCategories = true;
  String? _categoriesError;

  // 🆕 الـ sellerId الحقيقي بتاع اليوزر المسجل دخول، بيتجاب من /api/auth/me
  String? _sellerId;
  bool _loadingSeller = true;
  String? _sellerError;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchSellerId(); // 🆕
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _loadingCategories = true;
      _categoriesError = null;
    });

    try {
      final data = await _repository.getCategories();

      final map = <String, String>{
        for (final item in data) item['name']!: item['id']!,
      };

      if (!mounted) return;
      setState(() {
        _categoriesMap = map;
        _loadingCategories = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingCategories = false;
        _categoriesError = e.toString();
      });
    }
  }

  // 🆕 بتجيب بيانات اليوزر الحالي وتاخد الـ userId بتاعه كـ sellerId
  // ده بيحل مشكلة "Seller does not exist" اللي كانت بتظهر لما كنا
  // بنبعت UUID وهمي ثابت. دلوقتي بنبعت الـ id الحقيقي بتاع الحساب
  // المسجل دخول بيه فعليًا.
  Future<void> _fetchSellerId() async {
    setState(() {
      _loadingSeller = true;
      _sellerError = null;
    });

    try {
      final user = await _authRepository.getCurrentUser();

      if (!mounted) return;
      setState(() {
        _sellerId = user.userId;
        _loadingSeller = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingSeller = false;
        // لو فشل، غالبًا اليوزر مش مسجل دخول أصلاً (لازم يعمل Login الأول)
        _sellerError = e.toString();
      });
    }
  }

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

    if (_selectedCategoryName == null) {
      _showSnack('Please select a category', AppColors.error);
      return;
    }

    final categoryId = _categoriesMap[_selectedCategoryName!];
    if (categoryId == null) {
      _showSnack('Invalid category selected', AppColors.error);
      return;
    }

    // 🆕 لازم يكون عندنا sellerId حقيقي قبل ما نحفظ، وإلا السيرفر
    // هيرفض بـ "Seller does not exist" زي ما حصل قبل كده
    if (_sellerId == null) {
      _showSnack(
        'Could not verify your seller account. Please make sure you are logged in.',
        AppColors.error,
      );
      return;
    }

    final request = AddProductRequestModel(
      name: _nameController.text,
      description: _descController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      stock: int.tryParse(_stockController.text) ?? 0,
      categoryIds: [categoryId],

      // 🆕 بقى بيتجاب تلقائيًا من /api/auth/me بدل ما يبقى ثابت
      sellerId: _sellerId,

      // 🔧 TEMP HARDCODED — السيرفر طلب الحقول دي كـ required
      // ولسه معملناش لهم UI حقيقي في الشاشة. القيم دي شغالة
      // ومقبولة من السيرفر (السكرين شوت اللي فات أكد كده)،
      // بس لازم نستبدلها بحقول إدخال حقيقية قبل التسليم النهائي.

      // TODO: استبدلها بحقل إدخال عربي حقيقي في الشاشة
      nameArabic: 'اسم تجريبي',

      // TODO: استبدلها بحقل إدخال عربي حقيقي في الشاشة
      descriptionArabic: 'وصف تجريبي',

      // TODO: استبدلها بـ color picker حقيقي في الشاشة
      color: 'black',

      // TODO: دي أخطر حقل — لازم تتحط برابط حقيقي بعد رفع
      // الصورة فعليًا على endpoint مخصص (Files/Upload) وناخد
      // الرابط اللي بيرجعه، مش مسار ملف من الموبايل.
      coverPictureUrl: 'https://via.placeholder.com/400',
    );

    context.read<AddProductCubit>().addProduct(request);
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

  void _onDiscard() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        ),
        title: Text('Discard Draft?', style: AppTextStyles.headingSmall),
        content: Text(
          'All entered data will be lost.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary(context),
          ),
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
            child: Text('Discard', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          _showSnack('Product saved successfully!', AppColors.success);
          Navigator.pop(context);
        } else if (state is AddProductError) {
          _showSnack(state.message, AppColors.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is AddProductLoading;

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
                  const AddProductHeaderWidget(),
                  SizedBox(height: AppSizes.lg),

                  ProductImageUploadWidget(
                    onImageSelected: (image) => _selectedImage = image,
                  ),
                  SizedBox(height: AppSizes.lg),

                  LabeledTextFieldWidget(
                    label: 'Product Name',
                    hint: 'e.g. Royal Chronograph Silver',
                    controller: _nameController,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  SizedBox(height: AppSizes.md),

                  LabeledTextFieldWidget(
                    label: 'Description',
                    hint:
                        'Describe the craftsmanship, materials, and unique features...',
                    controller: _descController,
                    maxLines: 4,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  SizedBox(height: AppSizes.md),

                  LabeledDropdownWidget(
                    label: 'Category',
                    hint: _loadingCategories
                        ? 'Loading categories...'
                        : (_categoriesError != null
                              ? 'Failed to load — tap to retry'
                              : 'Select category'),
                    value: _selectedCategoryName,
                    items: _categoriesMap.keys.toList(),
                    onChanged: (val) =>
                        setState(() => _selectedCategoryName = val),
                  ),
                  if (_categoriesError != null) ...[
                    SizedBox(height: AppSizes.xs),
                    GestureDetector(
                      onTap: _fetchCategories,
                      child: Text(
                        'Could not load categories. Tap to retry.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                  // 🆕 تنبيه لو مش قدرنا نجيب هوية البائع (يعني غالبًا مش مسجل دخول)
                  if (_sellerError != null) ...[
                    SizedBox(height: AppSizes.xs),
                    GestureDetector(
                      onTap: _fetchSellerId,
                      child: Text(
                        'Could not verify your account. Please login. Tap to retry.',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: AppSizes.md),

                  PriceQuantityRowWidget(
                    priceController: _priceController,
                    quantityController: _stockController,
                  ),
                  SizedBox(height: AppSizes.xl),

                  SaveProductButtonWidget(
                    onSave: _onSave,
                    onDiscard: _onDiscard,
                    isLoading: isLoading,
                  ),

                  SizedBox(height: AppSizes.lg),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
