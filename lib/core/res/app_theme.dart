import 'package:bookia/core/res/app_colors.dart';
import 'package:bookia/core/res/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryDark),
      titleTextStyle: AppTextStyles.heading2,
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.heading1,
      displayMedium: AppTextStyles.heading2,
      bodyLarge: AppTextStyles.bodyMain,
      bodySmall: AppTextStyles.bodySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.button,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
