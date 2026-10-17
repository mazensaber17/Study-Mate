import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // Dynamic GoogleFonts styling helpers
  static TextStyle brandHeading({Color? color, double fontSize = 20}) =>
      GoogleFonts.fraunces(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        letterSpacing: -0.3,
        color: color ?? AppColors.textLight,
      );

  static TextStyle heading({Color? color, double fontSize = 26}) =>
      GoogleFonts.fraunces(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        letterSpacing: -0.4,
        color: color ?? AppColors.textLight,
      );

  static TextStyle label({Color? color, double fontSize = 11.5}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
        color: color ?? AppColors.secondaryTextLight,
      );

  static TextStyle bodyText({Color? color, double fontSize = 14}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textLight,
      );

  static TextStyle hint({Color? color, double fontSize = 14}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.inputText,
      );

  static TextStyle button({Color? color, double fontSize = 15}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.white,
      );

  static TextStyle subtitle({Color? color, double fontSize = 13.5}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color ?? AppColors.secondaryTextLight,
      );

  static TextStyle link({Color? color, double fontSize = 13.5}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.primaryLight,
      );
}
