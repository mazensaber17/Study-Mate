import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/student_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/app_validator.dart';
import '../../../app_routes.dart';
import '../../../shared/widgets/custom_dropdown_field.dart';
import '../../../shared/widgets/auth_feedback.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../cubit/registration_states.dart';
import '../cubit/registration_view_model.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _fullNameController;
  late final TextEditingController _collegeIdController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  String? _selectedYear;
  String? _selectedDepartment;
  String? _selectedSemester;
  bool _isLoadingDialogOpen = false;

  List<DropdownOption<String>> get _yearOptions => [
    DropdownOption(value: '1', label: AppStrings.year1.tr()),
    DropdownOption(value: '2', label: AppStrings.year2.tr()),
    DropdownOption(value: '3', label: AppStrings.year3.tr()),
    DropdownOption(value: '4', label: AppStrings.year4.tr()),
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _collegeIdController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _collegeIdController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final student = StudentModel(
        fullName: _fullNameController.text.trim(),
        collegeId: _collegeIdController.text.trim(),
        year: _selectedYear,
        universityEmail: _emailController.text.trim(),
        department: _selectedDepartment,
        semester: _selectedSemester,
      );

      context.read<RegistrationViewModel>().register(
        student: student,
        password: _passwordController.text,
      );
    }
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 400;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Full Name
              CustomTextField(
                label: AppStrings.fullName.tr(),
                hint: AppStrings.fullNameHint.tr(),
                controller: _fullNameController,
                validator: AppValidator.fullName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),

              // 2. Row: College ID (flex 3) + Year (flex 2)
              if (isCompact) ...[
                CustomTextField(
                  label: AppStrings.collegeId.tr(),
                  hint: AppStrings.collegeIdHint.tr(),
                  controller: _collegeIdController,
                  validator: AppValidator.collegeId,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  inputFormatters: AppValidator.collegeIdFormatters(),
                ),
                const SizedBox(height: 14),
                CustomDropdownField<String>(
                  label: AppStrings.year.tr(),
                  hint: AppStrings.yearHint.tr(),
                  value: _selectedYear,
                  items: [
                    DropdownOption(value: '1', label: AppStrings.year1.tr()),
                    DropdownOption(value: '2', label: AppStrings.year2.tr()),
                    DropdownOption(value: '3', label: AppStrings.year3.tr()),
                    DropdownOption(value: '4', label: AppStrings.year4.tr()),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedYear = value;
                    });
                  },
                  validator: (val) => AppValidator.requiredSelection(
                    val,
                    AppStrings.selectYear,
                  ),
                ),
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        label: AppStrings.collegeId.tr(),
                        hint: AppStrings.collegeIdHint.tr(),
                        controller: _collegeIdController,
                        validator: AppValidator.collegeId,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        inputFormatters: AppValidator.collegeIdFormatters(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: CustomDropdownField<String>(
                        label: AppStrings.year.tr(),
                        hint: AppStrings.yearHint.tr(),
                        value: _selectedYear,
                        items: _yearOptions,
                        onChanged: (value) =>
                            setState(() => _selectedYear = value),
                        validator: (val) => AppValidator.requiredSelection(
                          val,
                          AppStrings.selectYear,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 14),

              // 3. University Email
              CustomTextField(
                label: AppStrings.universityEmail.tr(),
                hint: AppStrings.universityEmailHint.tr(),
                controller: _emailController,
                validator: AppValidator.email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),

              // 4. Row: Department (flex 3) + Semester (flex 2)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomDropdownField<String>(
                      label: AppStrings.department.tr(),
                      hint: AppStrings.departmentHint.tr(),
                      value: _selectedDepartment,
                      items: [
                        DropdownOption(
                          value: 'CS',
                          label: AppStrings.deptCs.tr(),
                        ),
                        DropdownOption(
                          value: 'IS',
                          label: AppStrings.deptIs.tr(),
                        ),
                        DropdownOption(
                          value: 'AI',
                          label: AppStrings.deptAi.tr(),
                        ),
                        DropdownOption(
                          value: 'IT',
                          label: AppStrings.deptIt.tr(),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value;
                        });
                      },
                      validator: (val) => AppValidator.requiredSelection(
                        val,
                        AppStrings.selectDepartment,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CustomDropdownField<String>(
                      label: AppStrings.semester.tr(),
                      hint: AppStrings.semesterHint.tr(),
                      value: _selectedSemester,
                      items: [
                        DropdownOption(
                          value: 'S1',
                          label: AppStrings.semester1.tr(),
                        ),
                        DropdownOption(
                          value: 'S2',
                          label: AppStrings.semester2.tr(),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedSemester = value;
                        });
                      },
                      validator: (val) => AppValidator.requiredSelection(
                        val,
                        AppStrings.selectSemester,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 5. Password Field
              CustomTextField(
                label: AppStrings.password.tr(),
                hint: AppStrings.passwordHint.tr(),
                controller: _passwordController,
                validator: AppValidator.password,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 14),

              // 6. Confirm Password Field
              CustomTextField(
                label: AppStrings.confirmPassword.tr(),
                hint: AppStrings.confirmPasswordHint.tr(),
                controller: _confirmPasswordController,
                validator: (val) =>
                    AppValidator.confirmPassword(val, _passwordController.text),
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),

              // 7. Submit Button with Cubit State handling
              BlocConsumer<RegistrationViewModel, RegistrationState>(
                listener: (context, state) async {
                  if (state is RegistrationLoadingState) {
                    if (!_isLoadingDialogOpen) {
                      _isLoadingDialogOpen = true;
                      AuthFeedback.showLoading(
                        context,
                        message: 'Creating account...',
                      );
                    }
                    return;
                  }

                  if (_isLoadingDialogOpen) {
                    Navigator.of(context, rootNavigator: true).pop();
                    _isLoadingDialogOpen = false;
                  }

                  if (state is RegistrationSuccessState) {
                    await AuthFeedback.showSuccess(
                      context,
                      message: state.requiresEmailConfirmation
                          ? 'Account created. Check your email to confirm it, then sign in.'
                          : AppStrings.signUpSuccess.tr(),
                    );
                    if (!context.mounted) return;
                    Navigator.of(context).pushReplacementNamed(
                      state.requiresEmailConfirmation
                          ? AppRoutes.login
                          : AppRoutes.home,
                    );
                  } else if (state is RegistrationErrorState) {
                    if (state.isNetworkError) {
                      await AuthFeedback.showNoInternet(context);
                      return;
                    }
                    final message =
                        state.errorMessage.startsWith('key:') ||
                            state.errorMessage == AppStrings.invalidCredentials
                        ? state.errorMessage.tr()
                        : state.errorMessage;
                    await AuthFeedback.showError(context, message: message);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is RegistrationLoadingState;
                  return PrimaryButton(
                    label: AppStrings.joinButton.tr(),
                    isLoading: isLoading,
                    onPressed: _submit,
                  );
                },
              ),
              const SizedBox(height: 20),

              // 8. Footer: "Already have an account? Sign in"
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${AppStrings.alreadyHaveAccount.tr()} ',
                      style: AppStyles.subtitle(
                        color: promptColor,
                        fontSize: 13.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.login);
                      },
                      child: Text(
                        AppStrings.signIn.tr(),
                        style: AppStyles.link(color: linkColor, fontSize: 13.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
