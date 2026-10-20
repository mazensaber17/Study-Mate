import 'package:flutter/material.dart';

class StaggeredFormContent extends StatefulWidget {
  const StaggeredFormContent({required this.children, super.key});

  final List<Widget> children;

  @override
  State<StaggeredFormContent> createState() => _StaggeredFormContentState();
}

class _StaggeredFormContentState extends State<StaggeredFormContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 560 + widget.children.length * 70),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var index = 0; index < widget.children.length; index++)
              _AnimatedFormItem(
                index: index,
                itemCount: widget.children.length,
                progress: _controller.value,
                child: widget.children[index],
              ),
          ],
        );
      },
    );
  }
}

class _AnimatedFormItem extends StatelessWidget {
  const _AnimatedFormItem({
    required this.index,
    required this.itemCount,
    required this.progress,
    required this.child,
  });

  final int index;
  final int itemCount;
  final double progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final intervalLength = 0.58 / itemCount;
    final begin = index * intervalLength;
    final end = (begin + intervalLength * 1.8).clamp(0.0, 1.0);
    final intervalProgress = ((progress - begin) / (end - begin)).clamp(
      0.0,
      1.0,
    );
    final value = Curves.easeOutCubic.transform(intervalProgress);

    return Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 14 * (1 - value)),
        child: child,
      ),
    );
  }
}
