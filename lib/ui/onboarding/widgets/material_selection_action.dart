import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';

class MaterialSelectionAction extends StatefulWidget {
  const MaterialSelectionAction({
    required this.selectedCount,
    required this.onContinue,
    super.key,
  });

  final int selectedCount;
  final VoidCallback onContinue;

  @override
  State<MaterialSelectionAction> createState() =>
      _MaterialSelectionActionState();
}

class _MaterialSelectionActionState extends State<MaterialSelectionAction> {
  bool _isTransitioning = false;

  Future<void> _continue() async {
    if (_isTransitioning) return;
    setState(() => _isTransitioning = true);
    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (mounted) widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? AppColors.primaryDark : AppColors.primaryLight;

    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            '${widget.selectedCount} selected',
            style: GoogleFonts.inter(
              color: const Color(0xff00FF78),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _continue,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: isDark ? AppColors.textLight : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              child: _isTransitioning
                  ? const SizedBox(
                      key: ValueKey('continue-loading'),
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      'Continue',
                      key: const ValueKey('continue'),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}
