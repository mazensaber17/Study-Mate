class AppConfig {
  const AppConfig._();

  static const String supabaseUrl = 'https://fgsfqdnodcufrnlgfakj.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_za6k_UduQcFdSDwRdlXNPw_x80cU7hX';
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    // Use the computer's Wi-Fi IPv4 address when testing on a physical phone.
    // Override this with --dart-define=API_BASE_URL=... when the address changes.
    defaultValue: 'http://192.168.1.3:3000/api',
  );
}
