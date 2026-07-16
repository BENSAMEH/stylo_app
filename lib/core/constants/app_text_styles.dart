import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylo_app/core/constants/app_colors.dart';

/// Base typography scale for the app.
///
/// IMPORTANT: these styles intentionally leave `color` unset (except where a
/// fixed brand color is required, e.g. button text or price tags). When used
/// as `Text(..., style: AppTextStyles.xxx)` the color is inherited from the
/// nearest `DefaultTextStyle` / `Theme`, which makes text automatically
/// adapt to light/dark mode. If you need a specific color, use
/// `.copyWith(color: ...)` — prefer `AppColors.textPrimary(context)` /
/// `AppColors.textSecondary(context)` over hardcoded light/dark constants so
/// it keeps working in both themes.
class AppTextStyles {
  AppTextStyles._();

  // ─── Display ──────────────────────────────────────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.poppins(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get displayMedium => GoogleFonts.poppins(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
      );

  // ─── Headings ─────────────────────────────────────────────────────────────
  static TextStyle get headingLarge => GoogleFonts.poppins(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headingMedium => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get headingSmall => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );

  // ─── Body ─────────────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  // ─── Buttons ──────────────────────────────────────────────────────────────
  // Buttons keep a fixed white color since they sit on a solid primary-color
  // background in both themes.
  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      );

  // ─── Labels ───────────────────────────────────────────────────────────────
  static TextStyle get labelMedium => GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
      );

  // ─── Price ────────────────────────────────────────────────────────────────
  // Price keeps the fixed brand purple in both themes.
  static TextStyle get price => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  static TextStyle get priceOld => GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.lineThrough,
      );
}
