abstract class SettingsState {
  const SettingsState();
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState();
}

class SettingsLoadingState extends SettingsState {
  const SettingsLoadingState();
}

class SettingsErrorState extends SettingsState {
  const SettingsErrorState({required this.errorMessage});

  final String errorMessage;
}

class SettingsSuccessState extends SettingsState {
  const SettingsSuccessState();
}
