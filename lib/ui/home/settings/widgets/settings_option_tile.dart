import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class SettingsOptionTile extends StatelessWidget {
  const SettingsOptionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.value,
    this.onChanged,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textDark : AppColors.textLight;
    final secondaryColor = isDark
        ? AppColors.secondaryTextDark
        : AppColors.secondaryTextLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.cardLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: secondaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.bodyText(
                    color: textColor,
                    fontSize: 14,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.bodyText(color: secondaryColor, fontSize: 11),
                ),
              ],
            ),
          ),
          if (value != null)
            Switch(
              value: value!,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: isDark
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
            ),
        ],
      ),
    );
  }
}
