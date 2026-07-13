import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String? image;
  final IconData? icon; // غيرناها لـ IconData عشان نستخدم الـ List الاحتياطية بسهولة

  const CategoryCard({
    super.key,
    required this.title,
    this.image,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        color: AppColors.primary,
        // إضافة الصورة كخلفية للكارت لو موجودة
        image: image != null
            ? DecorationImage(
          image: NetworkImage(image!), // أو AssetImage حسب السيرفر بتاعك
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.primary.withOpacity(0.6), // تغميق الصورة عشان الكلام يبان
            BlendMode.srcOver,
          ),
        )
            : null,
      ),
      padding: EdgeInsets.all(AppSizes.md),
      child: Stack(
        children: [
          // إظهار الأيقونة الديناميكية أعلى اليسار
          if (icon != null)
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: AppColors.white.withOpacity(0.9),
                radius: 18,
                child: Icon(
                  icon,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
            ),

          // Title
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: AppTextStyles.headingSmall.copyWith(
                color:      AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}