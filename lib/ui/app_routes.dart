import 'package:flutter/material.dart';

import 'auth/registration/registration_screen.dart';
import 'home/chat_ai/chat_ai_screen.dart';
import 'home/home_screen.dart';
import 'home/news/news_screen.dart';
import 'home/settings/settings_screen.dart';
import 'home/summarizer/summarizer_screen.dart';
import 'splash/splash_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String news = '/news';
  static const String chatAi = '/chat-ai';
  static const String summarizer = '/summarizer';
  static const String settings = '/settings';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    registration: (_) => const RegistrationScreen(),
    home: (_) => const HomeScreen(),
    news: (_) => const NewsScreen(),
    chatAi: (_) => const ChatAiScreen(),
    summarizer: (_) => const SummarizerScreen(),
    settings: (_) => const SettingsScreen(),
  };
}
