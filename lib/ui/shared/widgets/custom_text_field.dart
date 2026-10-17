import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final bool enabled;
  final AutovalidateMode autovalidateMode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Text(
            widget.label!,
            style: AppStyles.label(color: labelColor),
          ),
          const SizedBox(height: 7),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          autovalidateMode: widget.autovalidateMode,
          style: AppStyles.bodyText(color: textColor, fontSize: 14.5),
          cursorColor: focusBorderColor,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hint,
            hintStyle: AppStyles.hint(color: hintColor, fontSize: 14),
            filled: true,
            fillColor: fillColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: isDark
                          ? AppColors.secondaryTextDark
                          : AppColors.secondaryTextLight,
                    ),
                    onPressed: _toggleObscure,
                    splashRadius: 20,
                  )
                : widget.suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: borderColor.withValues(alpha: 0.5),
                width: 1,
              ),
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
