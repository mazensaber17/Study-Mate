import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/utils/app_colors.dart';
import 'package:graduation_project/utils/assets_manager.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key, this.onOptionsPressed});

  final VoidCallback? onOptionsPressed;

  void _showQuickSettings(BuildContext context) {
    if (onOptionsPressed != null) {
      onOptionsPressed!();
      return;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = context.locale.languageCode == 'ar';

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                ListTile(
                  leading: Icon(
                    Icons.language_rounded,
                    color: isDark ? AppColors.primaryDark : AppColors.primaryLight,
                  ),
                  title: Text(
                    isArabic ? 'English' : 'العربية',
                    style: TextStyle(
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    isArabic ? 'Switch to English' : 'التحويل إلى اللغة العربية',
                    style: TextStyle(
                      color: isDark
                          ? AppColors.secondaryTextDark
                          : AppColors.secondaryTextLight,
                      fontSize: 12,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    if (isArabic) {
                      await context.setLocale(const Locale('en'));
                    } else {
                      await context.setLocale(const Locale('ar'));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.textDark : AppColors.textLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brand logo & name
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.splashMarkBackground
                    : AppColors.raisedLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(6.5),
              child: SvgPicture.asset(
                AssetsManager.studyMateMark,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 9),
            Text(
              'StudyMate',
              style: GoogleFonts.fraunces(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: textColor,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),

        // Three dots action pill
        InkWell(
          onTap: () => _showQuickSettings(context),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.raisedLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dot(isDark),
                const SizedBox(width: 3.5),
                _dot(isDark),
                const SizedBox(width: 3.5),
                _dot(isDark),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dot(bool isDark) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: isDark ? AppColors.textDark : AppColors.textLight,
        shape: BoxShape.circle,
      ),
    );
  }
}
