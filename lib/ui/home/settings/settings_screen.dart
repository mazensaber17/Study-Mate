import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api_manager.dart';
import '../../../repository/settings_repository.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/theme_controller.dart';
import '../../app_routes.dart';
import '../../shared/widgets/loading_indicator.dart';
import '../../shared/widgets/full_page_no_internet.dart';
import 'cubit/settings_states.dart';
import 'cubit/settings_view_model.dart';
import 'widgets/settings_option_tile.dart';
import 'widgets/settings_profile_header.dart';
import 'widgets/settings_sign_out_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SettingsViewModel(SettingsRepository(ApiManager()))..loadSettings(),
      child: const _SettingsContent(),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final student = AppLocalStorage.savedStudent;

    return ColoredBox(
      color: background,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          children: [
            Text(
              'Settings',
              style: AppStyles.heading(
                color: isDark ? AppColors.textDark : AppColors.textLight,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 24),
            SettingsProfileHeader(student: student),
            const SizedBox(height: 22),
            BlocBuilder<SettingsViewModel, SettingsState>(
              builder: (context, state) {
                if (state is SettingsLoadingState ||
                    state is SettingsInitialState) {
                  return const LoadingIndicator();
                }
                if (state is SettingsErrorState && state.isNetworkError) {
                  return FullPageNoInternet(
                    onTryAgain: context.read<SettingsViewModel>().loadSettings,
                  );
                }

                final notificationsEnabled = state is SettingsSuccessState
                    ? state.notificationsEnabled
                    : state is SettingsLoadedState
                    ? state.notificationsEnabled
                    : AppLocalStorage.notificationsEnabled;
                final isSigningOut = state is SettingsLoadedState &&
                    state.isSigningOut;

                return Column(
                  children: [
                    SettingsOptionTile(
                      title: 'Language',
                      subtitle: context.locale.languageCode == 'ar'
                          ? 'العربية'
                          : 'English',
                      icon: Icons.language_rounded,
                      value: context.locale.languageCode == 'ar',
                      onChanged: (_) async {
                        final nextLocale = context.locale.languageCode == 'ar'
                            ? const Locale('en')
                            : const Locale('ar');
                        await context.setLocale(nextLocale);
                      },
                    ),
                    const SizedBox(height: 12),
                    SettingsOptionTile(
                      title: 'Dark mode',
                      subtitle: isDark ? 'On' : 'Off',
                      icon: isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      value: isDark,
                      onChanged: ThemeController.instance.setDarkMode,
                    ),
                    const SizedBox(height: 12),
                    SettingsOptionTile(
                      title: 'Notifications',
                      subtitle: 'Quizzes, due dates and campus news',
                      icon: Icons.notifications_none_rounded,
                      value: notificationsEnabled,
                      onChanged: context
                          .read<SettingsViewModel>()
                          .setNotificationsEnabled,
                    ),
                    const SizedBox(height: 16),
                    SettingsSignOutButton(
                      isLoading: isSigningOut,
                      onPressed: () => _signOut(context),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await context.read<SettingsViewModel>().signOut();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed out successfully',
          style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
          backgroundColor:AppColors.primaryLight,
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 700));
      if (!context.mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.login,
        (route) => false,
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to sign out. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
