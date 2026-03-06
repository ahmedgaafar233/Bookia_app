import 'package:bookia/core/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryDark,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryDark,
  );

  static const TextStyle bodyMain = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryDark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.secondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
