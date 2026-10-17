import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class DropdownOption<T> {
  const DropdownOption({required this.value, required this.label});

  final T value;
  final String label;
}

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.items,
    this.value,
    this.label,
    this.hint,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final List<DropdownOption<T>> items;
  final T? value;
  final String? label;
  final String? hint;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final Color labelColor =
        isDark ? AppColors.secondaryTextDark : AppColors.secondaryTextLight;
    final Color textColor = isDark ? AppColors.textDark : AppColors.textLight;
    final Color hintColor = AppColors.inputText;
    final Color fillColor =
        isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color focusBorderColor =
        isDark ? AppColors.primaryDark : AppColors.primaryLight;
    final Color dropdownBgColor =
        isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: AppStyles.label(color: labelColor),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 7),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item.value,
              child: Text(
                item.label,
                style: AppStyles.bodyText(color: textColor, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: autovalidateMode,
          dropdownColor: dropdownBgColor,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDark
                ? AppColors.secondaryTextDark
                : AppColors.secondaryTextLight,
            size: 20,
          ),
          style: AppStyles.bodyText(color: textColor, fontSize: 14),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: AppStyles.hint(color: hintColor, fontSize: 14),
            filled: true,
            fillColor: fillColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: focusBorderColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              color: AppColors.error,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
