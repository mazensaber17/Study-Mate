import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../registration/widgets/brand_header.dart';
import '../../shared/widgets/responsive_content.dart';
import 'cubit/login_view_model.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color titleColor = isDark ? AppColors.textDark : AppColors.textLight;
    final Color subtitleColor = isDark
        ? AppColors.secondaryTextDark
        : AppColors.secondaryTextLight;

    return BlocProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: ResponsiveContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Brand Header with StudyMate mark + options
                const BrandHeader(),
                const SizedBox(height: 36),

                // Heading
                Text(
                  AppStrings.signIn.tr(),
                  style: AppStyles.heading(color: titleColor, fontSize: 26),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  AppStrings.signInSubtitle.tr(),
                  style: AppStyles.subtitle(
                    color: subtitleColor,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Login Form
                const LoginForm(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
