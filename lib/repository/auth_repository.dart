import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/student_model.dart';
import '../utils/app_strings.dart';

class AuthRepository {
  AuthRepository({this._client});

  final SupabaseClient? _client;

  SupabaseClient get client {
    if (_client != null) return _client;
    return Supabase.instance.client;
  }

  /// Sign up a new student account using Supabase Auth
  Future<AuthResponse> signUp({
    required StudentModel student,
    required String password,
  }) async {
    final email = student.universityEmail?.trim();
    if (email == null || email.isEmpty) {
      throw const AuthException('University email is required for sign up.');
    }

    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': student.fullName,
          'college_id': student.collegeId,
          'major': student.department,
          'semester': student.semester,
          'email': email,
        },
      );

      final user = response.user;
      if (user != null) {
        await client.from('profiles').upsert
          ({
          'id': user.id,
          'display_name': student.fullName,
          'college_id': student.collegeId,
          'major': student.department,
          'semester': student.semester,
          'email': email,
          'college_pass': password,
        });
      }

      return response;
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Sign in with the email registered in Supabase Auth.
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Sends a password reset email
  Future<void> resetPassword(String email) async {
    try {
      await client.auth.resetPasswordForEmail(email.trim());
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  /// Sign out current student session
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  /// Returns current authenticated user
  User? get currentUser {
    try {
      return client.auth.currentUser;
    } catch (_) {
      return null;
    }
  }

  /// Check if user is currently logged in
  bool get isAuthenticated => currentUser != null;

  /// Map common Supabase AuthExceptions to clear localized strings or messages
  AuthException _mapAuthException(AuthException error) {
    final msg = error.message.toLowerCase();
    if (msg.contains('invalid login credentials') ||
        msg.contains('invalid credentials')) {
      return const AuthException(AppStrings.invalidCredentials);
    }
    if (msg.contains('already registered') ||
        msg.contains('user already exists')) {
      return const AuthException('An account with this email already exists.');
    }
    if (msg.contains('email not confirmed')) {
      return const AuthException(
        'Please confirm your email before signing in.',
      );
    }
    if (msg.contains('password should be at least')) {
      return const AuthException('Password must be at least 6 characters.');
    }
    return error;
  }
}
