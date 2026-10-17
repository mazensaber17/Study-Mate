import 'package:supabase_flutter/supabase_flutter.dart';

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
  const RegistrationErrorState({
    required this.errorMessage,
    this.isNetworkError = false,
  });

  final String errorMessage;
  final bool isNetworkError;
}

class RegistrationSuccessState extends RegistrationState {
  const RegistrationSuccessState({this.user, this.session});

  final User? user;
  final Session? session;

  bool get requiresEmailConfirmation => user != null && session == null;
}
