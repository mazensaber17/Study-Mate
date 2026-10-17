import 'package:supabase_flutter/supabase_flutter.dart';

import '../api/api_manager.dart';
import '../model/student_model.dart';
import 'auth_repository.dart';

class RegistrationRepository {
  RegistrationRepository([ApiManager? apiManager, AuthRepository? authRepository])
      : apiManager = apiManager ?? ApiManager(),
        authRepository = authRepository ?? AuthRepository();

  final ApiManager apiManager;
  final AuthRepository authRepository;

  Future<AuthResponse> registerStudent({
    required StudentModel student,
    required String password,
  }) async {
    return authRepository.signUp(
      student: student,
      password: password,
    );
  }
}
