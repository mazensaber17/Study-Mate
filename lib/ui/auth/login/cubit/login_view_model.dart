import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../model/student_model.dart';
import '../../../../repository/auth_repository.dart';
import '../../../../utils/local_storage.dart';
import '../../../../utils/network_service.dart';
import 'login_states.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel([AuthRepository? repository])
    : repository = repository ?? AuthRepository(),
      super(const LoginInitialState());

  final AuthRepository repository;

  Future<void> login(String email, String password) async {
    emit(const LoginLoadingState());
    if (!await NetworkService.hasInternetConnection()) {
      emit(const LoginErrorState(errorMessage: '', isNetworkError: true));
      return;
    }
    try {
      final response = await repository.signIn(
        email: email,
        password: password,
      );
      await AppLocalStorage.saveStudent(
        StudentModel(universityEmail: response.user?.email ?? email.trim()),
      );
      emit(LoginSuccessState(user: response.user, session: response.session));
    } on AuthException catch (e) {
      emit(LoginErrorState(errorMessage: e.message));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    emit(const LoginLoadingState());
    if (!await NetworkService.hasInternetConnection()) {
      emit(const LoginErrorState(errorMessage: '', isNetworkError: true));
      return;
    }
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
