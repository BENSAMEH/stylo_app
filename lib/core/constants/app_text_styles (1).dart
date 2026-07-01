import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _font = 'Poppins';

  // ─── Display ──────────────────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _font, fontSize: 32, fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _font, fontSize: 26, fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  // ─── Headings ─────────────────────────────────────────────────────────────
  static const TextStyle headingLarge = TextStyle(
    fontFamily: _font, fontSize: 22, fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w600,
    color: AppColors.lightTextPrimary,
  );

  // ─── Body ─────────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font, fontSize: 14, fontWeight: FontWeight.w400,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _font, fontSize: 12, fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
  );

  // ─── Buttons ──────────────────────────────────────────────────────────────
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: _font, fontSize: 16, fontWeight: FontWeight.w600,
    color: AppColors.white, letterSpacing: 0.5,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _font, fontSize: 13, fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // ─── Labels ───────────────────────────────────────────────────────────────
  static const TextStyle labelMedium = TextStyle(
    fontFamily: _font, fontSize: 13, fontWeight: FontWeight.w500,
    color: AppColors.lightTextSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _font, fontSize: 11, fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
  );

  // ─── Price ────────────────────────────────────────────────────────────────
  static const TextStyle price = TextStyle(
    fontFamily: _font, fontSize: 18, fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static const TextStyle priceOld = TextStyle(
    fontFamily: _font, fontSize: 13, fontWeight: FontWeight.w400,
    color: AppColors.lightTextSecondary,
    decoration: TextDecoration.lineThrough,
  );
}
