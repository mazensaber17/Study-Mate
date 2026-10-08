import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  const AppStyles._();

  static const TextStyle brand = TextStyle(
    fontFamily: 'Fraunces',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    height: 1.23,
    color: AppColors.textLight,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Space Grotesk',
    fontSize: 14,
    color: AppColors.textLight,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Space Grotesk',
    fontSize: 9.5,
    fontWeight: FontWeight.w400,
    height: 1.26,
    letterSpacing: 0.5,
    color: AppColors.secondaryTextLight,
  );
}
