import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';

class OnboardingBottomControls extends StatelessWidget {
  const OnboardingBottomControls({
    required this.controller,
    required this.pageCount,
    required this.isLastPage,
    required this.onNext,
    super.key,
  });

  final PageController controller;
  final int pageCount;
  final bool isLastPage;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final buttonTextColor = isDark ? AppColors.textLight : Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: pageCount,
            effect: ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              expansionFactor: 3.6,
              spacing: 6,
              dotColor: isDark ? AppColors.borderDark : AppColors.borderLight,
              activeDotColor: buttonColor,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: buttonTextColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.08, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: Text(
                      isLastPage
                          ? AppStrings.getStarted.tr()
                          : AppStrings.next.tr(),
                      key: ValueKey(isLastPage),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Transform.flip(
                    flipX: Directionality.of(context) == ui.TextDirection.rtl,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: buttonTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
