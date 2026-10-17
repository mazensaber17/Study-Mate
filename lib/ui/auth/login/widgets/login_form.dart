import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/app_validator.dart';
import '../../../app_routes.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/auth_feedback.dart';
import '../../../shared/widgets/primary_button.dart';
import '../cubit/login_states.dart';
import '../cubit/login_view_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isLoadingDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginViewModel>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _onForgotPassword() {
    final input = _emailController.text.trim();
    if (input.isNotEmpty && input.contains('@')) {
      context.read<LoginViewModel>().resetPassword(input);
      return;
    }

    final emailController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                AppStrings.forgotPassword.tr(),
                style: AppStyles.heading(
                  color: isDark ? AppColors.textDark : AppColors.textLight,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.enterEmailForReset.tr(),
                style: AppStyles.subtitle(
                  color: isDark
                      ? AppColors.secondaryTextDark
                      : AppColors.secondaryTextLight,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 18),
              CustomTextField(
                label: AppStrings.universityEmail.tr(),
                hint: AppStrings.universityEmailHint.tr(),
                controller: emailController,
                validator: AppValidator.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: AppStrings.next.tr(),
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isNotEmpty && email.contains('@')) {
                    Navigator.pop(bottomSheetContext);
                    context.read<LoginViewModel>().resetPassword(email);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color linkColor = isDark
        ? AppColors.primaryDark
        : AppColors.primaryLight;
    final Color promptColor = isDark
        ? AppColors.secondaryTextDark
        : AppColors.secondaryTextLight;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // University email is Supabase Auth's sign-in identifier.
          CustomTextField(
            label: AppStrings.universityEmail.tr(),
            hint: AppStrings.universityEmailHint.tr(),
            controller: _emailController,
            validator: AppValidator.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),

          // Password Field
          CustomTextField(
            label: AppStrings.password.tr(),
            hint: AppStrings.passwordHint.tr(),
            controller: _passwordController,
            validator: AppValidator.password,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 10),

          // Forgot Password Link
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: GestureDetector(
              onTap: _onForgotPassword,
              child: Text(
                AppStrings.forgotPassword.tr(),
                style: AppStyles.subtitle(
                  color: isDark
                      ? AppColors.secondaryTextDark
                      : AppColors.secondaryTextLight,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Sign In Action Button
          BlocConsumer<LoginViewModel, LoginState>(
            listener: (context, state) async {
              if (state is LoginLoadingState) {
                if (!_isLoadingDialogOpen) {
                  _isLoadingDialogOpen = true;
                  AuthFeedback.showLoading(context, message: 'Signing in...');
                }
                return;
              }

              if (_isLoadingDialogOpen) {
                Navigator.of(context, rootNavigator: true).pop();
                _isLoadingDialogOpen = false;
              }

              if (state is LoginSuccessState) {
                await AuthFeedback.showSuccess(
                  context,
                  message: AppStrings.signInSuccess.tr(),
                );
                if (!context.mounted) return;
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              } else if (state is PasswordResetSentState) {
                await AuthFeedback.showSuccess(
                  context,
                  message: AppStrings.resetPasswordSent.tr(),
                );
              } else if (state is LoginErrorState) {
                if (state.isNetworkError) {
                  await AuthFeedback.showNoInternet(context);
                  return;
                }
                final message =
                    state.errorMessage == AppStrings.invalidCredentials
                    ? state.errorMessage.tr()
                    : state.errorMessage;
                await AuthFeedback.showError(context, message: message);
              }
            },
            builder: (context, state) {
              final isLoading = state is LoginLoadingState;
              return PrimaryButton(
                label: AppStrings.signIn.tr(),
                isLoading: isLoading,
                onPressed: _submit,
              );
            },
          ),
          const SizedBox(height: 22),

          // Footer: Don't have an account? Sign up
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${AppStrings.dontHaveAccount.tr()} ',
                  style: AppStyles.subtitle(color: promptColor, fontSize: 13.5),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.registration);
                  },
                  child: Text(
                    AppStrings.signUp.tr(),
                    style: AppStyles.link(color: linkColor, fontSize: 13.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
