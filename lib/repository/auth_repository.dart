import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/student_model.dart';
import '../utils/app_strings.dart';

class AuthRepository {
  AuthRepository({SupabaseClient? client}) : _client = client;

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
          'full_name': student.fullName,
          'college_id': student.collegeId,
          'year': student.year,
          'department': student.department,
          'semester': student.semester,
          'university_email': email,
        },
      );

      final user = response.user;
      if (user != null) {
        try {
          // Sync with the profiles table in Supabase
          await client.from('profiles').upsert({
            'id': user.id,
            'full_name': student.fullName,
            'college_id': student.collegeId,
            'email': email,
            'major': student.department,
            'semester': student.semester,
            'updated_at': DateTime.now().toIso8601String(),
          });
        } catch (_) {
          // If profiles table has RLS or specific schema, auth user_metadata is already saved
        }
      }

      return response;
    } on AuthException catch (e) {
      throw _mapAuthException(e);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Sign in using either College ID or University Email + Password
  Future<AuthResponse> signIn({
    required String identifier,
    required String password,
  }) async {
    final cleanIdentifier = identifier.trim();
    String email = cleanIdentifier;

    // If identifier doesn't have an @, look up email by college_id
    if (!cleanIdentifier.contains('@')) {
      try {
        final profileRes = await client
            .from('profiles')
            .select('email')
            .eq('college_id', cleanIdentifier)
            .maybeSingle();

        if (profileRes != null && profileRes['email'] != null) {
          email = profileRes['email'] as String;
        } else {
          throw const AuthException(
            'College ID not found. Please register or enter your university email.',
          );
        }
      } on AuthException {
        rethrow;
      } catch (_) {
        // Fallback: try identifier directly in case user entered username/email
        email = cleanIdentifier;
      }
    }

    try {
      final response = await client.auth.signInWithPassword(
        email: email,
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
    } catch (_) {}
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
    return error;
  }
}
