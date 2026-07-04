import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class ProductImageUploadWidget extends StatefulWidget {
  final void Function(File? image) onImageSelected;

  const ProductImageUploadWidget({super.key, required this.onImageSelected});

  @override
  State<ProductImageUploadWidget> createState() =>
      _ProductImageUploadWidgetState();
}

class _ProductImageUploadWidgetState extends State<ProductImageUploadWidget> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
      widget.onImageSelected(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  SizedBox(height: AppSizes.sm),
                  Text(
                    'Upload Product Image',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'High resolution PNG, JPG up to 10MB',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}