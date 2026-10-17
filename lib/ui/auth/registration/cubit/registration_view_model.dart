import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../model/student_model.dart';
import '../../../../repository/registration_repository.dart';
import '../../../../utils/local_storage.dart';
import '../../../../utils/network_service.dart';
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
    if (!await NetworkService.hasInternetConnection()) {
      emit(const RegistrationErrorState(errorMessage: '', isNetworkError: true));
      return;
    }
    try {
      final response = await repository.registerStudent(
        student: student,
        password: password,
      );
      if (response.session != null) {
        await AppLocalStorage.saveStudent(student);
      }
      emit(
        RegistrationSuccessState(
          user: response.user,
          session: response.session,
        ),
      );
    } on AuthException catch (e) {
      emit(RegistrationErrorState(errorMessage: e.message));
    } catch (e) {
      emit(RegistrationErrorState(errorMessage: e.toString()));
    }
  }
}
