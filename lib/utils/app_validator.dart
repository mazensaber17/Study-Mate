import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

import 'app_strings.dart';

class AppValidator {
  const AppValidator._();

  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return tr(AppStrings.fieldRequired);
    }
    return null;
  }

  static String? fullName(String? value) {
    final requiredError = requiredField(value);
    if (requiredError != null) return requiredError;

    if (value!.trim().length < 3) {
      return tr(AppStrings.enterValidName);
    }
    return null;
  }

  static String? collegeId(String? value) {
    final requiredError = requiredField(value);
    if (requiredError != null) return requiredError;

    // Allow alphanumeric, dash, underscore, or email (in case user inputs email in collegeId field)
    final regex = RegExp(r'^[A-Za-z0-9._%+-@]+$');
    if (!regex.hasMatch(value!.trim())) {
      return tr(AppStrings.enterValidCollegeId);
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value);
    if (requiredError != null) return requiredError;

    final emailPattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailPattern.hasMatch(value!.trim())) {
      return tr(AppStrings.enterValidEmail);
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = requiredField(value);
    if (requiredError != null) return requiredError;

    if (value!.trim().length < 6) {
      return tr(AppStrings.passwordTooShort);
    }
    return null;
  }

  static String? confirmPassword(String? confirm, String? original) {
    final requiredError = requiredField(confirm);
    if (requiredError != null) return requiredError;

    if (confirm != original) {
      return tr(AppStrings.passwordsDoNotMatch);
    }
    return null;
  }

  static String? requiredSelection(String? value, String errorKey) {
    if (value == null || value.trim().isEmpty) {
      return tr(errorKey);
    }
    return null;
  }

  static List<TextInputFormatter> collegeIdFormatters() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9._%+-@]')),
      LengthLimitingTextInputFormatter(50),
    ];
  }
}
