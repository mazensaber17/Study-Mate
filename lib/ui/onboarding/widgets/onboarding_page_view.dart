import 'package:flutter/material.dart';

import '../models/onboarding_item.dart';
import 'material_selection_slide.dart';
import 'onboarding_slide.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    required this.controller,
    required this.items,
    required this.currentPage,
    required this.onPageChanged,
    required this.onFinish,
    super.key,
  });

  static const materialSelectionPage = 3;

  final PageController controller;
  final List<OnboardingItem> items;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: items.length + 1,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        if (index == materialSelectionPage) {
          return MaterialSelectionSlide(
            onContinue: onFinish,
            isActive: currentPage == index,
          );
        }
        return OnboardingSlide(
          item: items[index],
          isActive: currentPage == index,
        );
      },
    );
  }
}
