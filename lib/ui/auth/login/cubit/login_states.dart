import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginErrorState extends LoginState {
  const LoginErrorState({required this.errorMessage});

  final String errorMessage;
}

class LoginSuccessState extends LoginState {
  const LoginSuccessState({this.user, this.session});

  final User? user;
  final Session? session;
}

class PasswordResetSentState extends LoginState {
  const PasswordResetSentState();
}
