import 'package:flutter/material.dart';

import '../../../../model/student_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({required this.student, super.key});

  final StudentModel? student;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? AppColors.textDark : AppColors.textLight;
    final subtitleColor = isDark
        ? AppColors.secondaryTextDark
        : AppColors.secondaryTextLight;
    final name = student?.fullName?.trim().isNotEmpty == true
        ? student!.fullName!
        : 'Student';

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: isDark ? AppColors.primaryDark : AppColors.primaryLight,
          child: Text(
            name.substring(0, 1).toUpperCase(),
            style: AppStyles.heading(color: AppColors.textLight, fontSize: 22),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: AppStyles.brandHeading(color: titleColor, fontSize: 18)),
            const SizedBox(height: 3),
            Text(
              'Year ${student?.year ?? '-'} · ${student?.department ?? '-'} · Sem ${student?.semester ?? '-'}',
              style: AppStyles.bodyText(color: subtitleColor, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
