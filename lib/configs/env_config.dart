class EnvironmentConfig {
  static const APP_NAME = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter Boilerplate',
  );
}