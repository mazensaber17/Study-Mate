import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme => _theme(
        brightness: Brightness.light,
        primary: AppColors.primaryLight,
        background: AppColors.backgroundLight,
        surface: AppColors.surfaceLight,
        text: AppColors.textLight,
        secondaryText: AppColors.secondaryTextLight,
        border: AppColors.borderLight,
      );

  static ThemeData get darkTheme => _theme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        background: AppColors.backgroundDark,
        surface: AppColors.surfaceDark,
        text: AppColors.textDark,
        secondaryText: AppColors.secondaryTextDark,
        border: AppColors.borderDark,
      );

  static ThemeData _theme({
    required Brightness brightness,
    required Color primary,
    required Color background,
    required Color surface,
    required Color text,
    required Color secondaryText,
    required Color border,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        surface: surface,
        onSurface: text,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: TextStyle(color: secondaryText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
      ),
    );
  }
}
