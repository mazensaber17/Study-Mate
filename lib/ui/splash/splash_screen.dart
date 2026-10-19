import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../utils/assets_manager.dart';
import '../../utils/local_storage.dart';
import '../app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _isExiting = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _navigateToNextScreen();
      }
    });
  }

  Future<void> _navigateToNextScreen() async {
    setState(() => _isExiting = true);
    await Future<void>.delayed(const Duration(milliseconds: 280));

    if (!mounted) return;
    final hasSession = Supabase.instance.client.auth.currentSession != null;
    final destination = hasSession
        ? AppRoutes.home
        : AppLocalStorage.hasCompletedOnboarding
        ? AppRoutes.login
        : AppRoutes.onboarding;
    Navigator.of(context).pushReplacementNamed(destination);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.splashDarkBackground
          : AppColors.backgroundLight,
      body: AnimatedScale(
        scale: _isExiting ? 0.94 : 1,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInCubic,
        child: AnimatedOpacity(
          opacity: _isExiting ? 0 : 1,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeInCubic,
          child: Center(
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
                  AppStrings.smartCampus.tr(),
                  style: AppStyles.caption.copyWith(
                    color: isDark
                        ? AppColors.secondaryTextDark
                        : AppColors.secondaryTextLight,
                  ),
                ),
              ],
            ),
          ),
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
