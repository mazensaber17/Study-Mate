import 'package:hive_flutter/hive_flutter.dart';

import '../model/news_model.dart';
import '../model/student_model.dart';

/// Device-local app state. Authentication credentials are never stored here:
/// Supabase persists and refreshes the signed-in session in secure storage.
class AppLocalStorage {
  AppLocalStorage._();

  static const _boxName = 'studymate_preferences';
  static const _hasCompletedOnboardingKey = 'has_completed_onboarding';
  static const _userKey = 'user';
  static const _isDarkModeKey = 'is_dark_mode';
  static const _newsKey = 'cached_news';
  static const _notificationsEnabledKey = 'notifications_enabled';

  static late Box<dynamic> _box;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<dynamic>(_boxName);
  }

  static bool get hasCompletedOnboarding =>
      _box.get(_hasCompletedOnboardingKey, defaultValue: false) as bool;

  static bool? get themeMode {
    final value = _box.get(_isDarkModeKey);
    return value is bool ? value : null;
  }

  static Future<void> saveThemeMode(bool isDark) {
    return _box.put(_isDarkModeKey, isDark);
  }

  static bool get notificationsEnabled =>
      _box.get(_notificationsEnabledKey, defaultValue: true) as bool;

  static Future<void> saveNotificationsEnabled(bool enabled) {
    return _box.put(_notificationsEnabledKey, enabled);
  }

  static Future<void> completeOnboarding() {
    return _box.put(_hasCompletedOnboardingKey, true);
  }

  static Future<void> saveStudent(StudentModel student) {
    return _box.put(_userKey, student.toJson());
  }

  static StudentModel? get savedStudent {
    final rawUser = _box.get(_userKey);
    if (rawUser is! Map) return null;

    return StudentModel.fromJson(Map<String, dynamic>.from(rawUser));
  }

  static Future<void> clearStudent() {
    return _box.delete(_userKey);
  }

  static Future<void> saveNews(List<NewsModel> news) {
    return _box.put(
      _newsKey,
      news.map((item) => item.toJson()).toList(),
    );
  }

  static List<NewsModel> get cachedNews {
    final rawNews = _box.get(_newsKey);
    if (rawNews is! List) return const [];

    return rawNews
        .whereType<Map>()
        .map((item) => NewsModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
