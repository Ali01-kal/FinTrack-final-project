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
  static const String routeTransport = '/transport';
  static const String routeGroceries = '/groceries';
  static const String routeRent = '/rent';
  static const String routeGifts = '/gifts';
  static const String routeMedicine = '/medicine';
  static const String routeEntertainment = '/entertainment';
  static const String routeSaving = '/saving';
  static const String routeDetailTravel = '/detailTravel';
  static const String routeAddSavings = '/addSavings';
  static const String routeNewHouse = '/newHouse';
  static const String routeCarDetail = '/carDetail';
  static const String routeWeddingDetail = '/weddingDetail';
  static const String routeProfile = '/profile';
  static const String routeEditProfile = '/editProfile';
  static const String routeSettings = '/settings';
  static const String routeNotificationSettings = '/notificationSettings';
  static const String routePasswordSettings = '/passwordSettings';
  static const String routeDeleteAccount = '/deleteAccount';
  static const String routeHelpCenter = '/helpCenter';

  // Ограничения валидации
  static const int kMinPasswordLength = 6;
  static const int kMaxTitleLength = 100;


  // app_constants.dart ішіне қосу
  static const String kTransactionsBox = 'transactions_box';
  static const String kUserBox = 'user_box';
  static const String kCategoriesBox = 'categories_box';
}
