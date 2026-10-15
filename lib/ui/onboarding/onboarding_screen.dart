import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../app_routes.dart';
import 'models/onboarding_item.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  final List<OnboardingItem> _items = OnboardingItem.items;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.registration);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLastPage = _currentPage == _items.length - 1;

    final Color backgroundColor =
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color buttonColor =
        isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final Color buttonTextColor =
        isDark ? AppColors.textLight : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with logo and Skip button
            OnboardingHeader(
              onSkip: _finishOnboarding,
              isLastPage: isLastPage,
            ),

            // PageView with onboarding slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingSlide(
                    item: _items[index],
                    isActive: _currentPage == index,
                  );
                },
              ),
            ),

            // Bottom controls: Page indicator & Action button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Smooth page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _items.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      expansionFactor: 3.6,
                      spacing: 6,
                      dotColor:
                          isDark ? AppColors.borderDark : AppColors.borderLight,
                      activeDotColor: isDark
                          ? AppColors.primaryDark
                          : AppColors.primaryLight,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bottom Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        foregroundColor: buttonTextColor,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.08, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Text(
                              isLastPage
                                  ? AppStrings.getStarted.tr()
                                  : AppStrings.next.tr(),
                              key: ValueKey<bool>(isLastPage),
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Transform.flip(
                            flipX: Directionality.of(context) ==
                                ui.TextDirection.rtl,
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
            ),
          ],
        ),
      ),
    );
  }
}
