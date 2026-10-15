import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_strings.dart';
import '../widgets/onboarding_icons.dart';

class OnboardingItem {
  const OnboardingItem({
    required this.titleKey,
    required this.descriptionKey,
    required this.iconBuilder,
  });

  final String titleKey;
  final String descriptionKey;
  final Widget Function(BuildContext context, Color color) iconBuilder;

  String get title => titleKey.tr();
  String get description => descriptionKey.tr();

  static List<OnboardingItem> get items => [
        OnboardingItem(
          titleKey: AppStrings.onboardingTitle1,
          descriptionKey: AppStrings.onboardingDesc1,
          iconBuilder: (context, color) => OnboardingNewsIcon(color: color),
        ),
        OnboardingItem(
          titleKey: AppStrings.onboardingTitle2,
          descriptionKey: AppStrings.onboardingDesc2,
          iconBuilder: (context, color) => OnboardingSparkleIcon(color: color),
        ),
        OnboardingItem(
          titleKey: AppStrings.onboardingTitle3,
          descriptionKey: AppStrings.onboardingDesc3,
          iconBuilder: (context, color) => OnboardingCheckIcon(color: color),
        ),
      ];
}
