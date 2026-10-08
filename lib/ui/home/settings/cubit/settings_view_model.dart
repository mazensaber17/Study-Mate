import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/settings_repository.dart';
import 'settings_states.dart';

class SettingsViewModel extends Cubit<SettingsState> {
  SettingsViewModel(this.repository) : super(const SettingsInitialState());

  final SettingsRepository repository;
}
