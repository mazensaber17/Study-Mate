abstract class SettingsState {
  const SettingsState();
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState();
}

class SettingsLoadedState extends SettingsState {
  const SettingsLoadedState({
    required this.notificationsEnabled,
    this.isSigningOut = false,
  });

  final bool notificationsEnabled;
  final bool isSigningOut;
}

class SettingsLoadingState extends SettingsState {
  const SettingsLoadingState();
}

class SettingsErrorState extends SettingsState {
  const SettingsErrorState({
    required this.errorMessage,
    this.isNetworkError = false,
  });

  final String errorMessage;
  final bool isNetworkError;
}

class SettingsSuccessState extends SettingsState {
  const SettingsSuccessState({required this.notificationsEnabled});

  final bool notificationsEnabled;
}
