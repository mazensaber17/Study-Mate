import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';

class MaterialSelectionHeader extends StatelessWidget {
  const MaterialSelectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose your\nmaterials.',
          style: GoogleFonts.spaceGrotesk(
            color: isDark ? AppColors.textDark : AppColors.textLight,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.08,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Select one or more to get started.',
          style: GoogleFonts.spaceGrotesk(
            color: isDark
                ? AppColors.secondaryTextDark
                : AppColors.secondaryTextLight,
            fontSize: 14,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
