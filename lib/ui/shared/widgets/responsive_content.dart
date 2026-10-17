import 'package:flutter/material.dart';

/// Keeps forms readable on tablets and prevents cramped margins on small phones.
class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    super.key,
    required this.child,
    this.maxWidth = 560,
    this.verticalPadding = 16,
  });

  final Widget child;
  final double maxWidth;
  final double verticalPadding;

  static double horizontalPaddingFor(double width) {
    if (width < 360) return 16;
    if (width >= 900) return 40;
    if (width >= 600) return 32;
    return 24;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = horizontalPaddingFor(constraints.maxWidth);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: verticalPadding,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
