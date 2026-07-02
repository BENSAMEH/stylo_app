import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stylo_app/core/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ─── Display ──────────────────────────────────────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.poppins(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.lightTextPrimary,
      );

  static TextStyle get displayMedium => GoogleFonts.poppins(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.lightTextPrimary,
      );

  // ─── Headings ─────────────────────────────────────────────────────────────
  static TextStyle get headingLarge => GoogleFonts.poppins(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.lightTextPrimary,
      );

  static TextStyle get headingMedium => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      );

  static TextStyle get headingSmall => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.lightTextPrimary,
      );

  // ─── Body ─────────────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
      );

  // ─── Buttons ──────────────────────────────────────────────────────────────
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
        color: AppColors.lightTextSecondary,
      );

  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
      );

  // ─── Price ────────────────────────────────────────────────────────────────
  static TextStyle get price => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  static TextStyle get priceOld => GoogleFonts.poppins(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
        decoration: TextDecoration.lineThrough,
      );
}