import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/auth_repository.dart';
import '../../../../repository/settings_repository.dart';
import '../../../../utils/network_service.dart';
import 'settings_states.dart';

class SettingsViewModel extends Cubit<SettingsState> {
  SettingsViewModel(this.repository, {AuthRepository? authRepository})
    : authRepository = authRepository ?? AuthRepository(),
      super(const SettingsInitialState());

  final SettingsRepository repository;
  final AuthRepository authRepository;

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

  Future<void> signOut() async {
    final notificationsEnabled = state is SettingsLoadedState
        ? (state as SettingsLoadedState).notificationsEnabled
        : repository.notificationsEnabled;
    emit(
      SettingsLoadedState(
        notificationsEnabled: notificationsEnabled,
        isSigningOut: true,
      ),
    );
    try {
      await authRepository.signOut();
      emit(
        SettingsLoadedState(
          notificationsEnabled: notificationsEnabled,
        ),
      );
    } catch (error) {
      emit(
        SettingsErrorState(
          errorMessage: error.toString(),
        ),
      );
      emit(
        SettingsLoadedState(
          notificationsEnabled: notificationsEnabled,
        ),
      );
      rethrow;
    }
  }
}
