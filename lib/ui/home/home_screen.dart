import 'package:flutter/material.dart';

import '../shared/widgets/app_bottom_navigation_bar.dart';
import '../shared/widgets/animated_tab_view.dart';
import 'chat_ai/chat_ai_screen.dart';
import 'news/news_screen.dart';
import 'settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages = const [
    NewsScreen(embedded: true),
    ChatAiScreen(),
    SettingsScreen(),
  ];

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedTabView(
        index: _currentIndex,
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
