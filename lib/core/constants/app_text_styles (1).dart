import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylo_app/core/constants/app_colors%20(1).dart';


class AppTextStyles {
  AppTextStyles._();

  static const String _font = 'Poppins';

  // ─── Display ──────────────────────────────────────────────────────────────
  static TextStyle get displayLarge => TextStyle(
    fontFamily: _font, fontSize: 32.sp, fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: _font, fontSize: 26.sp, fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  // ─── Headings ─────────────────────────────────────────────────────────────
  static TextStyle get headingLarge => TextStyle(
    fontFamily: _font, fontSize: 22.sp, fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle get headingMedium => TextStyle(
    fontFamily: _font, fontSize: 18.sp, fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle get headingSmall => TextStyle(
    fontFamily: _font, fontSize: 16.sp, fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
  );

  // ─── Body ─────────────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: _font, fontSize: 16.sp, fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: _font, fontSize: 14.sp, fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: _font, fontSize: 12.sp, fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
  );

  // ─── Buttons ──────────────────────────────────────────────────────────────
  static TextStyle get buttonLarge => TextStyle(
    fontFamily: _font, fontSize: 16.sp, fontWeight: FontWeight.w600,
    color: AppColors.white, letterSpacing: 0.5,
  );

  static TextStyle get buttonSmall => TextStyle(
    fontFamily: _font, fontSize: 13.sp, fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // ─── Labels ───────────────────────────────────────────────────────────────
  static TextStyle get labelMedium => TextStyle(
    fontFamily: _font, fontSize: 13.sp, fontWeight: FontWeight.w500,
    color: AppColors.lightTextSecondary,
  );

  static TextStyle get caption => TextStyle(
    fontFamily: _font, fontSize: 11.sp, fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
  );

  // ─── Price ────────────────────────────────────────────────────────────────
  static TextStyle get price => TextStyle(
    fontFamily: _font, fontSize: 18.sp, fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get priceOld => TextStyle(
    fontFamily: _font, fontSize: 13.sp, fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
    decoration: TextDecoration.lineThrough,
  );
}