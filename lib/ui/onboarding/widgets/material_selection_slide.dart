import 'package:flutter/material.dart';

import '../models/study_material.dart';
import 'material_selection_action.dart';
import 'material_selection_header.dart';
import 'material_selection_list.dart';

class MaterialSelectionSlide extends StatefulWidget {
  const MaterialSelectionSlide({
    required this.onContinue,
    required this.isActive,
    super.key,
  });

  final VoidCallback onContinue;
  final bool isActive;

  @override
  State<MaterialSelectionSlide> createState() => _MaterialSelectionSlideState();
}

class _MaterialSelectionSlideState extends State<MaterialSelectionSlide>
    with SingleTickerProviderStateMixin {
  final Set<int> _selectedMaterialIds = {};
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1050),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isActive && !_animationController.isAnimating) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant MaterialSelectionSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isActive && widget.isActive) {
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMaterial(int materialId) {
    setState(() {
      if (!_selectedMaterialIds.remove(materialId)) {
        _selectedMaterialIds.add(materialId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 34, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeTransition(
            opacity: pageAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.08, 0),
                end: Offset.zero,
              ).animate(pageAnimation),
              child: const MaterialSelectionHeader(),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return MaterialSelectionList(
                materials: StudyMaterial.available,
                selectedIds: _selectedMaterialIds,
                onChanged: _toggleMaterial,
                animationValue: _animationController.value,
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _animationController,
                curve: const Interval(0.75, 1, curve: Curves.easeOutCubic),
              ),
              child: MaterialSelectionAction(
                selectedCount: _selectedMaterialIds.length,
                onContinue: widget.onContinue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
