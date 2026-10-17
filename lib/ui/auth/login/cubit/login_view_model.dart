import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../repository/auth_repository.dart';
import 'login_states.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel([AuthRepository? repository])
      : repository = repository ?? AuthRepository(),
        super(const LoginInitialState());

  final AuthRepository repository;

  Future<void> login(String identifier, String password) async {
    emit(const LoginLoadingState());
    try {
      final response = await repository.signIn(
        identifier: identifier,
        password: password,
      );
      emit(LoginSuccessState(
        user: response.user,
        session: response.session,
      ));
    } on AuthException catch (e) {
      emit(LoginErrorState(errorMessage: e.message));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const LoginLoadingState());
    try {
      await repository.resetPassword(email);
      emit(const PasswordResetSentState());
    } on AuthException catch (e) {
      emit(LoginErrorState(errorMessage: e.message));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
}
