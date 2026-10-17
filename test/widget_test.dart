import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/ui/app_routes.dart';
import 'package:graduation_project/ui/auth/registration/registration_screen.dart';
import 'package:graduation_project/ui/onboarding/onboarding_screen.dart';
import 'package:graduation_project/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestAssetLoader extends AssetLoader {
  const TestAssetLoader();

  static const Map<String, dynamic> en = {
    'app_name': 'StudyMate',
    'smart_campus': 'SMART CAMPUS',
    'skip': 'Skip',
    'next': 'Next',
    'get_started': 'Get started',
    'onboarding_title_1': 'Your campus,\nin one place.',
    'onboarding_desc_1':
        'Catch up with campus news, course updates, and important announcements.',
    'onboarding_title_2': 'A little help.\nA lot more clarity.',
    'onboarding_desc_2':
        'Ask StudyMate for concise summaries, explanations, and quick answers.',
    'onboarding_title_3': 'Make space\nfor better study.',
    'onboarding_desc_3':
        'Plan your schedule, organize notes, and focus on what matters to you.',
  };

  static const Map<String, dynamic> ar = {
    'app_name': 'StudyMate',
    'smart_campus': 'الحرم الذكي',
    'skip': 'تخطي',
    'next': 'التالي',
    'get_started': 'ابدأ الآن',
    'onboarding_title_1': 'حرمك الجامعي،\nفي مكان واحد.',
    'onboarding_desc_1':
        'تابع أخبار الحرم الجامعي، وتحديثات المقررات، والإعلانات المهمة.',
    'onboarding_title_2': 'مساعدة ذكية.\nلوضوح أكثر.',
    'onboarding_desc_2':
        'اسأل StudyMate للحصول على ملخصات دقيقة، وشروحات، وإجابات سريعة.',
    'onboarding_title_3': 'نظّم وقتك\nلدراسة أفضل.',
    'onboarding_desc_3':
        'خطط لجدولك الدراسي، ونظم ملاحظاتك، وركز على ما يهمك.',
  };

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    if (locale.languageCode == 'ar') return ar;
    return en;
  }
}

Widget createTestApp({
  Widget? home,
  String? initialRoute,
  Map<String, WidgetBuilder>? routes,
  Locale locale = const Locale('en'),
  ThemeData? theme,
  ThemeMode? themeMode,
}) {
  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: locale,
    assetLoader: const TestAssetLoader(),
    child: Builder(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: theme ?? AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode ?? ThemeMode.system,
          home: home,
          initialRoute: initialRoute,
          routes: routes ?? const <String, WidgetBuilder>{},
        );
      },
    ),
  );
}

Future<void> pumpTestApp(
  WidgetTester tester, {
  Widget? home,
  String? initialRoute,
  Map<String, WidgetBuilder>? routes,
  Locale locale = const Locale('en'),
  ThemeData? theme,
  ThemeMode? themeMode,
}) async {
  await tester.pumpWidget(
    createTestApp(
      home: home,
      initialRoute: initialRoute,
      routes: routes,
      locale: locale,
      theme: theme,
      themeMode: themeMode,
    ),
  );
  await tester.pump();
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableLevels = [];
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('StudyMate app transitions from splash to onboarding',
      (tester) async {
    await tester.pumpWidget(
      createTestApp(
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
    await tester.pump();

    expect(find.text('StudyMate'), findsOneWidget);
    expect(find.text('SMART CAMPUS'), findsOneWidget);

    // Advance fake timer by 2 seconds
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Your campus,\nin one place.'), findsOneWidget);
  });

  testWidgets('OnboardingScreen navigates through slides and buttons',
      (tester) async {
    await pumpTestApp(
      tester,
      home: const OnboardingScreen(),
    );

    // Verify first slide content
    expect(find.text('Your campus,\nin one place.'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);

    // Tap Next to go to slide 2
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('A little help.\nA lot more clarity.'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Tap Next to go to slide 3
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Make space\nfor better study.'), findsOneWidget);
    expect(find.text('Get started'), findsOneWidget);
  });

  testWidgets('OnboardingScreen supports Arabic localization', (tester) async {
    await pumpTestApp(
      tester,
      home: const OnboardingScreen(),
      locale: const Locale('ar'),
    );

    expect(find.text('حرمك الجامعي،\nفي مكان واحد.'), findsOneWidget);
    expect(find.text('التالي'), findsOneWidget);
    expect(find.text('تخطي'), findsOneWidget);
  });

  testWidgets('OnboardingScreen supports dark mode rendering', (tester) async {
    await pumpTestApp(
      tester,
      home: const OnboardingScreen(),
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );

    expect(find.text('Your campus,\nin one place.'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('Skip button navigates to registration route', (tester) async {
    await pumpTestApp(
      tester,
      initialRoute: AppRoutes.onboarding,
      routes: AppRoutes.routes,
    );

    expect(find.text('Skip'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byType(RegistrationScreen), findsOneWidget);
  });
}
