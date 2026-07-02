import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  AppSizes._();

  // ─── Padding & Margin ─────────────────────────────────────────────────────
  static double get xs  => 4.r;
  static double get sm  => 8.r;
  static double get md  => 16.r;
  static double get lg  => 24.r;
  static double get xl  => 32.r;
  static double get xxl => 48.r;

  // ─── Screen horizontal padding ────────────────────────────────────────────
  static double get screenPadding => 16.w;

  // ─── Border radius ────────────────────────────────────────────────────────
  static double get radiusXs   => 4.r;
  static double get radiusSm   => 8.r;
  static double get radiusMd   => 12.r;
  static double get radiusLg   => 16.r;
  static double get radiusXl   => 24.r;
  static double get radiusFull => 100.r;

  // ─── Icon sizes ───────────────────────────────────────────────────────────
  static double get iconSm => 16.r;
  static double get iconMd => 24.r;
  static double get iconLg => 32.r;
  static double get iconXl => 48.r;

  // ─── Button ───────────────────────────────────────────────────────────────
  static double get buttonHeight   => 52.h;
  static double get buttonHeightSm => 40.h;

  // ─── Input field ──────────────────────────────────────────────────────────
  static double get inputHeight => 56.h;

  // ─── Card ─────────────────────────────────────────────────────────────────
  static double get cardElevation => 2.r;
  static double get cardRadius    => 16.r;

  // ─── Product card ─────────────────────────────────────────────────────────
  static double get productCardWidth   => 160.w;
  static double get productCardHeight  => 220.h;
  static double get productImageHeight => 140.h;

  // ─── AppBar ───────────────────────────────────────────────────────────────
  static double get appBarHeight => 60.h;

  // ─── Bottom nav ───────────────────────────────────────────────────────────
  static double get bottomNavHeight => 64.h;

  // ─── Avatar ───────────────────────────────────────────────────────────────
  static double get avatarSm => 32.r;
  static double get avatarMd => 48.r;
  static double get avatarLg => 80.r;
  static double get avatarXl => 120.r;

  // ─── Offer banner ─────────────────────────────────────────────────────────
  static double get offerBannerHeight => 180.h;

  // ─── Section spacing ──────────────────────────────────────────────────────
  static double get sectionSpacing => 24.h;
}