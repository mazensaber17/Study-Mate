import '../api/api_manager.dart';
import '../utils/local_storage.dart';

class SettingsRepository {
  SettingsRepository(this.apiManager);

  final ApiManager apiManager;

  bool get notificationsEnabled => AppLocalStorage.notificationsEnabled;

  Future<void> setNotificationsEnabled(bool enabled) {
    return AppLocalStorage.saveNotificationsEnabled(enabled);
  }
}
