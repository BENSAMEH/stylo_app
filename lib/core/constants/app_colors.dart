import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ───────────────── Brand ─────────────────
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF4B44CC);
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent = Color(0xFFFFBE0B);

  // ─────────────── Light Colors ───────────────
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightDivider = Color(0xFFE5E7EB);

  // ─────────────── Dark Colors ───────────────
  static const Color darkBackground = Color(0xFF0F0F1A);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkCardBg = Color(0xFF16213E);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkDivider = Color(0xFF2D3748);

  // ─────────────── Semantic ───────────────
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // ─────────────── Misc ───────────────
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color starColor = accent;

  // =====================================================
  // Theme Helpers
  // =====================================================

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color background(BuildContext context) {
    return isDark(context)
        ? darkBackground
        : lightBackground;
  }

  static Color surface(BuildContext context) {
    return isDark(context)
        ? darkSurface
        : lightSurface;
  }

  static Color card(BuildContext context) {
    return isDark(context)
        ? darkCardBg
        : lightCardBg;
  }

  static Color textPrimary(BuildContext context) {
    return isDark(context)
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color textSecondary(BuildContext context) {
    return isDark(context)
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static Color divider(BuildContext context) {
    return isDark(context)
        ? darkDivider
        : lightDivider;
  }
}