import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../models/study_material.dart';

class MaterialSelectionList extends StatelessWidget {
  const MaterialSelectionList({
    required this.materials,
    required this.selectedIds,
    required this.onChanged,
    required this.animationValue,
    super.key,
  });

  final List<StudyMaterial> materials;
  final Set<int> selectedIds;
  final ValueChanged<int> onChanged;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < materials.length; index++)
          _AnimatedMaterialTile(
            index: index,
            animationValue: animationValue,
            child: MaterialSelectionTile(
              material: materials[index],
              selected: selectedIds.contains(materials[index].id),
              onTap: () => onChanged(materials[index].id),
            ),
          ),
      ],
    );
  }
}

class _AnimatedMaterialTile extends StatelessWidget {
  const _AnimatedMaterialTile({
    required this.index,
    required this.animationValue,
    required this.child,
  });

  final int index;
  final double animationValue;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final start = 0.12 + index * 0.08;
    final end = (start + 0.17).clamp(0.0, 1.0);
    final intervalProgress = ((animationValue - start) / (end - start)).clamp(
      0.0,
      1.0,
    );
    final value = Curves.easeOutCubic.transform(intervalProgress);

    return Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(18 * (1 - value), 0),
        child: child,
      ),
    );
  }
}

class MaterialSelectionTile extends StatelessWidget {
  const MaterialSelectionTile({
    required this.material,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final StudyMaterial material;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textDark : AppColors.textLight;
    final borderColor = isDark
        ? AppColors.secondaryTextDark
        : AppColors.borderLight;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Expanded(
              child: Text(
                material.name,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(color: textColor, fontSize: 14),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? const Color(0xff00FF78) : Colors.transparent,
                border: selected ? null : Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(5),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                child: selected
                    ? Icon(
                        Icons.check_rounded,
                        key: const ValueKey('checked'),
                        size: 16,
                        color: isDark ? AppColors.textLight : Colors.white,
                      )
                    : const SizedBox(key: ValueKey('unchecked')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
