import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';

class NewsSection extends StatelessWidget {
  const NewsSection({
    required this.items,
    this.title,
    super.key,
  });

  final String? title;
  final List<NewsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          _SectionTitle(title: title!),
          const SizedBox(height: 10),
        ],
        for (var index = 0; index < items.length; index++) ...[
          _AnimatedNewsEntry(
            index: index,
            child: items[index],
          ),
          if (index < items.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

}

class _AnimatedNewsEntry extends StatefulWidget {
  const _AnimatedNewsEntry({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;

  @override
  State<_AnimatedNewsEntry> createState() => _AnimatedNewsEntryState();
}

class _AnimatedNewsEntryState extends State<_AnimatedNewsEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _startTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _startTimer = Timer(
      Duration(milliseconds: widget.index * 120),
      _controller.forward,
    );
  }

  @override
  void dispose() {
    _startTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(animation),
        child: widget.child,
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({
    required this.title,
    required this.metadata,
    this.snippet,
    this.highlighted = false,
    this.compact = false,
    super.key,
  });

  final String title;
  final String metadata;
  final String? snippet;
  final bool highlighted;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? AppColors.textDark : AppColors.textLight;
    final metadataColor = isDark
        ? AppColors.secondaryTextDark
        : AppColors.secondaryTextLight;
    final borderColor = highlighted
        ? (isDark ? AppColors.primaryDark : AppColors.primaryLight)
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    return Container(
      constraints: BoxConstraints(minHeight: compact ? 66 : 82),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.cardLight,
        border: Border.all(
          color: borderColor,
          width: highlighted ? 1.3 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: compact ? 1 : 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.bodyText(
              color: titleColor,
              fontSize: compact ? 13 : 14,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
          if (snippet != null && snippet!.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              snippet!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.bodyText(
                color: metadataColor,
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 7),
          Text(
            metadata,
            style: AppStyles.bodyText(color: metadataColor, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      title.toUpperCase(),
      style: AppStyles.label(
        color: isDark
            ? AppColors.secondaryTextDark
            : AppColors.secondaryTextLight,
        fontSize: 11,
      ),
    );
  }
}
