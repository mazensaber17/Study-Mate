import 'package:flutter/services.dart';

class AppValidator {
  const AppValidator._();

  static String? requiredField(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = requiredField(value, fieldName: 'Email');
    if (requiredError != null) {
      return requiredError;
    }

    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailPattern.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? collegeId(String? value) {
    final requiredError = requiredField(value, fieldName: 'College ID');
    if (requiredError != null) {
      return requiredError;
    }

    if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(value!.trim())) {
      return 'Enter a valid College ID';
    }
    return null;
  }

  static String? selection(String? value, {String fieldName = 'Selection'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select $fieldName';
    }
    return null;
  }

  static List<TextInputFormatter> collegeIdFormatters() {
    return [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9_-]'))];
  }
}
