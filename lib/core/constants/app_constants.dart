// Слой: core | Назначение: глобальные константы приложения

class AppConstants {
  AppConstants._();

  // Ключи SharedPreferences
  static const String kSessionKey = 'session_user_id';
  static const String kUserEmailKey = 'session_user_email';

  // Имя файла базы данных
  static const String kDatabaseName = 'app_database.sqlite';

  // Маршруты
  static const String routeSplash = '/splash';
  static const String routeWelcome = '/welcome';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeHome = '/home';
  static const String routeNotifications = '/notifications';
  static const String routeAccountBalance = '/accountBalance';
  static const String routeQuiklyAnalytics = '/quiklyanalytics';
  static const String routeAnalysis = '/analysis';
  static const String routeSearch = '/search';
  static const String routeCalendar = '/calendar';
  static const String routeTransaction = '/transaction';
  static const String routeCategories = '/categories';
  static const String routeFood = '/food';
  static const String routeAddExpences = '/addexpense';

  // Ограничения валидации
  static const int kMinPasswordLength = 6;
  static const int kMaxTitleLength = 100;
}
