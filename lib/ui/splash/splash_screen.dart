import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.splashDarkBackground
          : AppColors.backgroundLight,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _StudyMateMark(),
            const SizedBox(height: 18),
            Text(
              'StudyMate',
              style: AppStyles.brand.copyWith(
                color: isDark ? AppColors.textDark : AppColors.textLight,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'SMART CAMPUS',
              style: AppStyles.caption.copyWith(
                color: isDark
                    ? AppColors.secondaryTextDark
                    : AppColors.secondaryTextLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudyMateMark extends StatelessWidget {
  const _StudyMateMark();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.splashMarkBackground,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.2),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SizedBox(
        width: 75,
        height: 75,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Semantics(
            label: 'StudyMate logo',
            image: true,
            child: SvgPicture.asset(
              AssetsManager.studyMateMark,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
