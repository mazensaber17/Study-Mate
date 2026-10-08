import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/ui/app_routes.dart';
import 'package:graduation_project/utils/app_theme.dart';

import 'utils/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const StudyMateApp());
}
class StudyMateApp extends StatelessWidget {
  const StudyMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudyMate',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
