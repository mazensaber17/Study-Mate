import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/app_validator.dart';
import '../../../app_routes.dart';
import '../../../shared/widgets/custom_text_field.dart';
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

  late final TextEditingController _collegeIdController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _collegeIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _collegeIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginViewModel>().login(
            _collegeIdController.text.trim(),
            _passwordController.text,
          );
    }
  }

  void _onForgotPassword() {
    final input = _collegeIdController.text.trim();
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
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
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
    final Color linkColor =
        isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final Color promptColor =
        isDark ? AppColors.secondaryTextDark : AppColors.secondaryTextLight;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // College ID / Email Field
          CustomTextField(
            label: AppStrings.collegeId.tr(),
            hint: AppStrings.collegeIdHint.tr(),
            controller: _collegeIdController,
            validator: AppValidator.collegeId,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            inputFormatters: AppValidator.collegeIdFormatters(),
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
            listener: (context, state) {
              if (state is LoginSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppStrings.signInSuccess.tr()),
                    backgroundColor: AppColors.primaryLight,
                  ),
                );
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              } else if (state is PasswordResetSentState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppStrings.resetPasswordSent.tr()),
                    backgroundColor: AppColors.primaryLight,
                  ),
                );
              } else if (state is LoginErrorState) {
                final message = state.errorMessage == AppStrings.invalidCredentials
                    ? state.errorMessage.tr()
                    : state.errorMessage;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.error,
                  ),
                );
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
                    Navigator.of(context).pushReplacementNamed(
                      AppRoutes.registration,
                    );
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
