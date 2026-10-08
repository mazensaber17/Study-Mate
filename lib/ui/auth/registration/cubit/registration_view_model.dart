import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/registration_repository.dart';
import 'registration_states.dart';

class RegistrationViewModel extends Cubit<RegistrationState> {
  RegistrationViewModel(this.repository) : super(const RegistrationInitialState());

  final RegistrationRepository repository;
}
