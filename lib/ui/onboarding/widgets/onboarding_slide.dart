import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../models/onboarding_item.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.item,
    required this.isActive,
  });

  final OnboardingItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color iconColor =
        isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final Color cardBackground =
        isDark ? AppColors.raisedDark : AppColors.raisedLight;
    final Color cardBorder =
        isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color titleColor = isDark ? AppColors.textDark : AppColors.textLight;
    final Color descColor =
        isDark ? AppColors.secondaryTextDark : AppColors.secondaryTextLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 3),

          // Central rounded icon card
          Center(
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                color: cardBackground,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: cardBorder,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.3)
                        : AppColors.primaryLight.withValues(alpha: 0.12),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: item.iconBuilder(context, iconColor),
            )
                .animate(target: isActive ? 1 : 0)
                .scale(
                  begin: const Offset(0.85, 0.85),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                )
                .fade(duration: 350.ms),
          ),

          const Spacer(flex: 2),

          // Title
          Text(
            context.tr(item.titleKey),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.22,
              letterSpacing: -0.5,
              color: titleColor,
            ),
          )
              .animate(target: isActive ? 1 : 0)
              .fade(duration: 400.ms, delay: 100.ms)
              .slideY(
                begin: 0.18,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),

          const SizedBox(height: 12),

          // Description
          Text(
            context.tr(item.descriptionKey),
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14.5,
              fontWeight: FontWeight.w400,
              height: 1.48,
              color: descColor,
              letterSpacing: 0.1,
            ),
          )
              .animate(target: isActive ? 1 : 0)
              .fade(duration: 400.ms, delay: 180.ms)
              .slideY(
                begin: 0.18,
                end: 0,
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),

          const Spacer(flex: 4),
        ],
      ),
    );
  }
}
