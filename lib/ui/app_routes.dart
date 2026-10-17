import 'package:flutter/material.dart';

import 'auth/login/login_screen.dart';
import 'auth/registration/registration_screen.dart';
import 'home/chat_ai/chat_ai_screen.dart';
import 'home/home_screen.dart';
import 'home/news/news_screen.dart';
import 'home/settings/settings_screen.dart';
import 'home/summarizer/summarizer_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'splash/splash_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String news = '/news';
  static const String chatAi = '/chat-ai';
  static const String summarizer = '/summarizer';
  static const String settings = '/settings';

  static final Map<String, WidgetBuilder> _pageBuilders = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    login: (_) => const LoginScreen(),
    registration: (_) => const RegistrationScreen(),
    home: (_) => const HomeScreen(),
    news: (_) => const NewsScreen(),
    chatAi: (_) => const ChatAiScreen(),
    summarizer: (_) => const SummarizerScreen(),
    settings: (_) => const SettingsScreen(),
  };

  static Map<String, WidgetBuilder> get routes => _pageBuilders;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = _pageBuilders[settings.name];
    if (builder == null) return null;

    return PageRouteBuilder<void>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          builder(context),
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.04, 0),
          end: Offset.zero,
        ).animate(curvedAnimation);
        final fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(curvedAnimation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
