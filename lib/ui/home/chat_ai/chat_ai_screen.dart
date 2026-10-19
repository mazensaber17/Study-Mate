import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/assets_manager.dart';

class ChatAiScreen extends StatelessWidget {
  const ChatAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AssetsManager.aiRobotAnimation,
                  width: 280,
                  height: 280,
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ),
                const SizedBox(height: 16),
                Text(
                  'Oops',
                  style: AppStyles.heading(
                    color: isDark ? AppColors.textDark : AppColors.textLight,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'No internet connection',
                  style: AppStyles.subtitle(
                    color: isDark
                        ? AppColors.secondaryTextDark
                        : AppColors.secondaryTextLight,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
