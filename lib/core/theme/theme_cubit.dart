import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/shared_pref_service.dart';

/// Manages the app's [ThemeMode] and keeps it in sync with SharedPreferences
/// so the user's choice survives app restarts.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(SharedPrefService.getThemeMode());

  /// Toggles between light and dark (used by the simple on/off switch in
  /// the Profile screen). If the current mode is [ThemeMode.system], it
  /// resolves to dark first.
  void toggleTheme() {
    final isCurrentlyDark = state == ThemeMode.dark;
    setTheme(isCurrentlyDark ? ThemeMode.light : ThemeMode.dark);
  }

  /// Explicitly sets the theme mode (light / dark / system) and persists it.
  void setTheme(ThemeMode mode) {
    emit(mode);
    SharedPrefService.saveThemeMode(mode);
  }
}
