import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/model/student_model.dart';
import 'package:graduation_project/ui/app_routes.dart';
import 'package:graduation_project/ui/auth/login/login_screen.dart';
import 'package:graduation_project/ui/auth/registration/registration_screen.dart';
import 'package:graduation_project/utils/app_config.dart';
import 'package:graduation_project/utils/app_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthTestAssetLoader extends AssetLoader {
  const AuthTestAssetLoader();

  static const Map<String, dynamic> en = {
    'app_name': 'StudyMate',
    'sign_in': 'Sign in',
    'sign_in_subtitle': 'Sign in to access your courses and campus services.',
    'college_id': 'COLLEGE ID',
    'college_id_hint': 'e.g. 2024-cs-0142',
    'password': 'PASSWORD',
    'password_hint': '••••••••',
    'confirm_password': 'CONFIRM PASSWORD',
    'confirm_password_hint': '••••••••',
    'forgot_password': 'Forgot password?',
    'dont_have_account': "Don't have an account?",
    'sign_up': 'Sign up',
    'join_campus': 'Join your campus',
    'register_subtitle': 'Set up your student profile to get started',
    'full_name': 'FULL NAME',
    'full_name_hint': 'Ahmed Salah',
    'year': 'YEAR',
    'year_hint': 'Year 3',
    'year_1': 'Year 1',
    'year_2': 'Year 2',
    'year_3': 'Year 3',
    'year_4': 'Year 4',
    'university_email': 'UNIVERSITY EMAIL',
    'university_email_hint': 'ahmed@univ.edu.eg',
    'department': 'DEPARTMENT',
    'department_hint': 'CS',
    'dept_cs': 'Computer Science',
    'dept_is': 'Information Systems',
    'dept_ai': 'Artificial Intelligence',
    'dept_it': 'Information Technology',
    'semester': 'SEMESTER',
    'semester_hint': 'S1',
    'semester_1': 'Semester 1',
    'semester_2': 'Semester 2',
    'already_have_account': 'Already have an account?',
    'join_button': 'Sign up',
    'field_required': 'This field is required',
    'enter_valid_college_id': 'Enter a valid College ID (e.g. 2024-cs-0142)',
    'enter_valid_email': 'Enter a valid university email',
    'password_too_short': 'Password must be at least 6 characters',
    'passwords_do_not_match': 'Passwords do not match',
    'enter_valid_name': 'Please enter your full name',
    'select_year': 'Please select your academic year',
    'select_department': 'Please select your department',
    'select_semester': 'Please select your semester',
    'sign_up_success': 'Account created successfully!',
    'sign_in_success': 'Signed in successfully!',
    'invalid_credentials': 'Invalid credentials. Please verify your College ID/Email and password.',
    'college_id_not_found': 'College ID not found. Please register or enter your University Email.',
    'reset_password_sent': 'Password reset link sent to your email.',
    'enter_email_for_reset': 'Please enter your university email to reset your password.',
  };

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return en;
  }
}

Widget createAuthTestApp(Widget home) {
  return EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/translations',
    assetLoader: const AuthTestAssetLoader(),
    child: Builder(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: home,
          routes: {
            AppRoutes.login: (_) => const LoginScreen(),
            AppRoutes.registration: (_) => const RegistrationScreen(),
          },
        );
      },
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    try {
      await Supabase.initialize(
        url: AppConfig.supabaseUrl,
        anonKey: AppConfig.supabaseAnonKey,
      );
    } catch (_) {}
  });

  group('StudentModel Tests', () {
    test('creates instance with all fields and serialization', () {
      const student = StudentModel(
        fullName: 'Ahmed Salah',
        collegeId: '2024-cs-0142',
        year: '3',
        universityEmail: 'ahmed@univ.edu.eg',
        department: 'CS',
        semester: 'S1',
        password: 'password123',
      );

      expect(student.fullName, 'Ahmed Salah');
      expect(student.collegeId, '2024-cs-0142');
      expect(student.year, '3');
      expect(student.universityEmail, 'ahmed@univ.edu.eg');
      expect(student.department, 'CS');
      expect(student.semester, 'S1');
      expect(student.password, 'password123');

      final json = student.toJson();
      expect(json['full_name'], 'Ahmed Salah');
      expect(json['college_id'], '2024-cs-0142');

      final fromJson = StudentModel.fromJson(json);
      expect(fromJson.fullName, 'Ahmed Salah');
      expect(fromJson.universityEmail, 'ahmed@univ.edu.eg');
    });
  });

  group('AppValidator Unit Tests', () {
    test('requiredField validates null and empty string', () {
      expect(AppValidator.requiredField(null), isNotNull);
      expect(AppValidator.requiredField(''), isNotNull);
      expect(AppValidator.requiredField('   '), isNotNull);
      expect(AppValidator.requiredField('valid'), isNull);
    });

    test('fullName validates length', () {
      expect(AppValidator.fullName(''), isNotNull);
      expect(AppValidator.fullName('Ab'), isNotNull);
      expect(AppValidator.fullName('Ahmed Salah'), isNull);
    });

    test('collegeId validates format', () {
      expect(AppValidator.collegeId(''), isNotNull);
      expect(AppValidator.collegeId('2024-cs-0142'), isNull);
      expect(AppValidator.collegeId('2024_IT_001'), isNull);
      expect(AppValidator.collegeId('student@univ.edu'), isNull);
      expect(AppValidator.collegeId('invalid id with spaces'), isNotNull);
    });

    test('email validates format', () {
      expect(AppValidator.email(''), isNotNull);
      expect(AppValidator.email('invalid-email'), isNotNull);
      expect(AppValidator.email('student@campus.edu'), isNull);
    });

    test('password validates minimum 6 characters', () {
      expect(AppValidator.password(''), isNotNull);
      expect(AppValidator.password('12345'), isNotNull);
      expect(AppValidator.password('123456'), isNull);
      expect(AppValidator.password('securePassword123'), isNull);
    });

    test('confirmPassword checks equality', () {
      expect(AppValidator.confirmPassword('', '123456'), isNotNull);
      expect(AppValidator.confirmPassword('123457', '123456'), isNotNull);
      expect(AppValidator.confirmPassword('123456', '123456'), isNull);
    });
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('renders brand header, fields, and buttons', (tester) async {
      await tester.pumpWidget(createAuthTestApp(const LoginScreen()));
      await tester.pumpAndSettle();

      expect(find.text('StudyMate'), findsWidgets);
      expect(find.text('Sign in'), findsWidgets);
      expect(find.text('COLLEGE ID'), findsOneWidget);
      expect(find.text('PASSWORD'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text("Don't have an account? "), findsOneWidget);
      expect(find.text('Sign up'), findsOneWidget);
    });

    testWidgets('validates required fields on submission', (tester) async {
      await tester.pumpWidget(createAuthTestApp(const LoginScreen()));
      await tester.pumpAndSettle();

      final signInButton = find.widgetWithText(FilledButton, 'Sign in');
      expect(signInButton, findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsNWidgets(2));
    });
  });

  group('RegistrationScreen Widget Tests', () {
    testWidgets('renders brand header and all form fields', (tester) async {
      await tester.pumpWidget(createAuthTestApp(const RegistrationScreen()));
      await tester.pumpAndSettle();

      expect(find.text('StudyMate'), findsWidgets);
      expect(find.text('Join your campus'), findsOneWidget);
      expect(find.text('FULL NAME'), findsOneWidget);
      expect(find.text('COLLEGE ID'), findsOneWidget);
      expect(find.text('YEAR'), findsOneWidget);
      expect(find.text('UNIVERSITY EMAIL'), findsOneWidget);
      expect(find.text('DEPARTMENT'), findsOneWidget);
      expect(find.text('SEMESTER'), findsOneWidget);
      expect(find.text('PASSWORD'), findsOneWidget);
      expect(find.text('CONFIRM PASSWORD'), findsOneWidget);
      expect(find.text('Already have an account? '), findsOneWidget);
    });

    testWidgets('validates required registration fields on submit', (tester) async {
      await tester.pumpWidget(createAuthTestApp(const RegistrationScreen()));
      await tester.pumpAndSettle();

      final signUpButton = find.widgetWithText(FilledButton, 'Sign up');
      expect(signUpButton, findsOneWidget);
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsWidgets);
    });
  });
}
