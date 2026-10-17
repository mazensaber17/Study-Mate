import 'package:hive_flutter/hive_flutter.dart';

import '../model/student_model.dart';

/// Device-local app state. Authentication credentials are never stored here:
/// Supabase persists and refreshes the signed-in session in secure storage.
class AppLocalStorage {
  AppLocalStorage._();

  static const _boxName = 'studymate_preferences';
  static const _hasCompletedOnboardingKey = 'has_completed_onboarding';
  static const _userKey = 'user';

  static late Box<dynamic> _box;

  static Future<void> initialize() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<dynamic>(_boxName);
  }

  static bool get hasCompletedOnboarding =>
      _box.get(_hasCompletedOnboardingKey, defaultValue: false) as bool;

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
}
