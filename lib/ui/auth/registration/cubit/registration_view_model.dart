import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../model/student_model.dart';
import '../../../../repository/registration_repository.dart';
import 'registration_states.dart';

class RegistrationViewModel extends Cubit<RegistrationState> {
  RegistrationViewModel(this.repository)
      : super(const RegistrationInitialState());

  final RegistrationRepository repository;

  Future<void> register({
    required StudentModel student,
    required String password,
  }) async {
    emit(const RegistrationLoadingState());
    try {
      final response = await repository.registerStudent(
        student: student,
        password: password,
      );
      emit(RegistrationSuccessState(
        user: response.user,
        session: response.session,
      ));
    } on AuthException catch (e) {
      emit(RegistrationErrorState(errorMessage: e.message));
    } catch (e) {
      emit(RegistrationErrorState(errorMessage: e.toString()));
    }
  }
}
