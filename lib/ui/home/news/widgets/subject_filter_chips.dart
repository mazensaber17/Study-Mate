import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class NewsAudienceLabel extends StatelessWidget {
  const NewsAudienceLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      'FOR YOU · YEAR 2 · CIS · SEM 1',
      style: AppStyles.label(
        color: isDark
            ? AppColors.secondaryTextDark
            : AppColors.secondaryTextLight,
        fontSize: 11,
      ),
    );
  }
}

class SubjectFilterChips extends StatelessWidget {
  const SubjectFilterChips({super.key});

  static const subjects = ['Database Systems', 'OOP', 'Statistics'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipColor = isDark ? AppColors.raisedDark : AppColors.raisedLight;
    final textColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: subjects
            .map(
              (subject) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _SubjectChip(
                  label: subject,
                  backgroundColor: chipColor,
                  textColor: textColor,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SubjectChip extends StatelessWidget {
  const _SubjectChip({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: AppStyles.label(color: textColor, fontSize: 10),
        ),
      ),
    );
  }
}
