abstract class RegistrationState {
  const RegistrationState();
}

class RegistrationInitialState extends RegistrationState {
  const RegistrationInitialState();
}

class RegistrationLoadingState extends RegistrationState {
  const RegistrationLoadingState();
}

class RegistrationErrorState extends RegistrationState {
  const RegistrationErrorState({required this.errorMessage});

  final String errorMessage;
}

class RegistrationSuccessState extends RegistrationState {
  const RegistrationSuccessState();
}
