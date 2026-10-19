import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/settings_repository.dart';
import '../../../../utils/network_service.dart';
import 'settings_states.dart';

class SettingsViewModel extends Cubit<SettingsState> {
  SettingsViewModel(this.repository) : super(const SettingsInitialState());

  final SettingsRepository repository;

  Future<void> loadSettings() async {
    emit(const SettingsLoadingState());
    if (!await NetworkService.hasInternetConnection()) {
      emit(
        const SettingsErrorState(
          errorMessage: 'No internet connection',
          isNetworkError: true,
        ),
      );
      return;
    }

    emit(
      SettingsLoadedState(
        notificationsEnabled: repository.notificationsEnabled,
      ),
    );
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final previous = state is SettingsLoadedState
        ? (state as SettingsLoadedState).notificationsEnabled
        : repository.notificationsEnabled;
    try {
      await repository.setNotificationsEnabled(enabled);
      emit(SettingsLoadedState(notificationsEnabled: enabled));
    } catch (error) {
      emit(
        SettingsErrorState(
          errorMessage: error.toString(),
        ),
      );
      emit(SettingsLoadedState(notificationsEnabled: previous));
    }
  }
}
