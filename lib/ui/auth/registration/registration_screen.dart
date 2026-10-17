import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api_manager.dart';
import '../../../repository/registration_repository.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import 'cubit/registration_view_model.dart';
import 'widgets/auth_form.dart';
import 'widgets/brand_header.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor =
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color titleColor =
        isDark ? AppColors.textDark : AppColors.textLight;
    final Color subtitleColor =
        isDark ? AppColors.secondaryTextDark : AppColors.secondaryTextLight;

    return BlocProvider(
      create: (_) => RegistrationViewModel(
        RegistrationRepository(ApiManager()),
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Brand Header with StudyMate mark + options
                const BrandHeader(),
                const SizedBox(height: 32),

                // Heading
                Text(
                  AppStrings.joinCampus.tr(),
                  style: AppStyles.heading(color: titleColor, fontSize: 26),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  AppStrings.registerSubtitle.tr(),
                  style: AppStyles.subtitle(color: subtitleColor, fontSize: 13.5),
                ),
                const SizedBox(height: 28),

                // Registration Form
                const AuthForm(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
