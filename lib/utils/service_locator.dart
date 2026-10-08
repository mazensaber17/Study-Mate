import '../api/api_manager.dart';
import '../repository/chat_repository.dart';
import '../repository/news_repository.dart';
import '../repository/registration_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/summarizer_repository.dart';

class AppDependencies {
  AppDependencies({ApiManager? apiManager})
      : apiManager = apiManager ?? ApiManager();

  final ApiManager apiManager;

  late final registrationRepository = RegistrationRepository(apiManager);
  late final newsRepository = NewsRepository(apiManager);
  late final chatRepository = ChatRepository(apiManager);
  late final summarizerRepository = SummarizerRepository(apiManager);
  late final settingsRepository = SettingsRepository(apiManager);
}
