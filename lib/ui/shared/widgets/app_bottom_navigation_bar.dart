import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({required this.currentIndex, this.onTap, super.key});

  final int currentIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.article_outlined), label: 'News'),
        NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat AI'),
        NavigationDestination(icon: Icon(Icons.summarize_outlined), label: 'Summarizer'),
        NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
      ],
    );
  }
}
