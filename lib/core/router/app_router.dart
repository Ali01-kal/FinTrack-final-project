import 'package:fintrack/core/constants/app_constants.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/screens/account/account_balance.dart';
import 'package:fintrack/presentation/screens/analysis/analysis_screen.dart';
import 'package:fintrack/presentation/screens/analysis/calendar_screen.dart';
import 'package:fintrack/presentation/screens/analysis/quikly_analysis_screen.dart';
import 'package:fintrack/presentation/screens/analysis/search_screen.dart';
import 'package:fintrack/presentation/screens/auth/login_screen.dart';
import 'package:fintrack/presentation/screens/auth/register_screen.dart';
import 'package:fintrack/presentation/screens/auth/welcome_screen.dart';
import 'package:fintrack/presentation/screens/categories/add_expences.dart';
import 'package:fintrack/presentation/screens/categories/add_savings_screen.dart';
import 'package:fintrack/presentation/screens/categories/add_transaction_screen.dart';
import 'package:fintrack/presentation/screens/categories/car_detail_screen.dart';
import 'package:fintrack/presentation/screens/categories/categories_screen.dart';
import 'package:fintrack/presentation/screens/categories/entartainment_screen.dart';
import 'package:fintrack/presentation/screens/categories/food_screen.dart';
import 'package:fintrack/presentation/screens/categories/gifts_screen.dart';
import 'package:fintrack/presentation/screens/categories/groceries_screen.dart';
import 'package:fintrack/presentation/screens/categories/medicine_screen.dart';
import 'package:fintrack/presentation/screens/categories/new_house_detail_screen.dart';
import 'package:fintrack/presentation/screens/categories/rent_screen.dart';
import 'package:fintrack/presentation/screens/categories/saving_screen.dart';
import 'package:fintrack/presentation/screens/categories/transport_screen.dart';
import 'package:fintrack/presentation/screens/categories/travel_detail_screen.dart';
import 'package:fintrack/presentation/screens/categories/wedding_detail_screen.dart';
import 'package:fintrack/presentation/screens/home/home_screen.dart';
import 'package:fintrack/presentation/screens/notifications/notifications_screen.dart';
import 'package:fintrack/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:fintrack/presentation/screens/profile/delete_account_screen.dart';
import 'package:fintrack/presentation/screens/profile/edit_profile_screen.dart';
import 'package:fintrack/presentation/screens/profile/help_center_screen.dart';
import 'package:fintrack/presentation/screens/profile/notification_settings_screen.dart';
import 'package:fintrack/presentation/screens/profile/password_settings_screen.dart';
import 'package:fintrack/presentation/screens/profile/profile_screen.dart';
import 'package:fintrack/presentation/screens/profile/settings_screen.dart';
import 'package:fintrack/presentation/screens/splash/splash_screen.dart';
import 'package:fintrack/presentation/screens/transactions/transactions_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

const Set<String> _transientRoutes = <String>{
  AppConstants.routeSplash,
  AppConstants.routeOnboarding,
  AppConstants.routeWelcome,
  AppConstants.routeLogin,
  AppConstants.routeRegister,
};

void _saveLastRoute(String route) {
  if (_transientRoutes.contains(route)) return;
  final box = Hive.box(AppConstants.kUserBox);
  box.put(AppConstants.kLastRouteKey, route);
}

final appRouter = GoRouter(
  initialLocation: AppConstants.routeSplash,
  debugLogDiagnostics: true,
  redirect: (context, state) {
    _saveLastRoute(state.matchedLocation);
    return null;
  },
  routes: [
    GoRoute(path: AppConstants.routeSplash, builder: (context, state) => const SplashScreen()),
    GoRoute(path: AppConstants.routeOnboarding, builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: AppConstants.routeWelcome, builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: AppConstants.routeLogin, builder: (context, state) => const LoginScreen()),
    GoRoute(path: AppConstants.routeRegister, builder: (context, state) => const RegisterScreen()),
    GoRoute(path: AppConstants.routeHome, builder: (context, state) => const HomeScreen()),
    GoRoute(path: AppConstants.routeNotifications, builder: (context, state) => const NotificationScreen()),
    GoRoute(path: AppConstants.routeAccountBalance, builder: (context, state) => const AccountBalanceScreen()),
    GoRoute(path: AppConstants.routeQuiklyAnalytics, builder: (context, state) => const QuiklyAnalysisScreen()),
    GoRoute(path: AppConstants.routeAnalysis, builder: (context, state) => const AnalysisScreen()),
    GoRoute(path: AppConstants.routeSearch, builder: (context, state) => const SearchScreen()),
    GoRoute(path: AppConstants.routeCalendar, builder: (context, state) => const CalendarScreen()),
    GoRoute(path: AppConstants.routeTransaction, builder: (context, state) => const TransactionScreen()),
    GoRoute(path: AppConstants.routeCategories, builder: (context, state) => const CategoriesScreen()),
    GoRoute(path: AppConstants.routeFood, builder: (context, state) => const FoodScreen()),
    GoRoute(path: AppConstants.routeAddExpences, builder: (context, state) => const AddExpenseScreen()),
    GoRoute(path: AppConstants.routeTransport, builder: (context, state) => const TransportScreen()),
    GoRoute(path: AppConstants.routeGroceries, builder: (context, state) => const GroceriesScreen()),
    GoRoute(path: AppConstants.routeRent, builder: (context, state) => const RentScreen()),
    GoRoute(path: AppConstants.routeGifts, builder: (context, state) => const GiftsScreen()),
    GoRoute(path: AppConstants.routeMedicine, builder: (context, state) => const MedicineScreen()),
    GoRoute(path: AppConstants.routeEntertainment, builder: (context, state) => const EntertainmentScreen()),
    GoRoute(path: AppConstants.routeSaving, builder: (context, state) => const SavingsScreen()),
    GoRoute(path: AppConstants.routeDetailTravel, builder: (context, state) => const TravelDetailScreen()),
    GoRoute(path: AppConstants.routeAddSavings, builder: (context, state) => const AddSavingsScreen()),
    GoRoute(path: AppConstants.routeNewHouse, builder: (context, state) => const NewHouseDetailScreen()),
    GoRoute(path: AppConstants.routeCarDetail, builder: (context, state) => const CarDetailScreen()),
    GoRoute(path: AppConstants.routeWeddingDetail, builder: (context, state) => const WeddingDetailScreen()),
    GoRoute(path: AppConstants.routeProfile, builder: (context, state) => const ProfileScreen()),
    GoRoute(path: AppConstants.routeEditProfile, builder: (context, state) => const EditProfileScreen()),
    GoRoute(path: AppConstants.routeSettings, builder: (context, state) => const SettingsScreen()),
    GoRoute(
      path: AppConstants.routeNotificationSettings,
      builder: (context, state) => const NotificationSettingsScreen(),
    ),
    GoRoute(path: AppConstants.routePasswordSettings, builder: (context, state) => const PasswordSettingsScreen()),
    GoRoute(path: AppConstants.routeDeleteAccount, builder: (context, state) => const DeleteAccountScreen()),
    GoRoute(path: AppConstants.routeHelpCenter, builder: (context, state) => const HelpCenterScreen()),
    GoRoute(
      path: AppConstants.routeIncome,
      builder: (context, state) => const AddTransactionScreen(
        categoryName: 'Income',
        categoryId: 'income_id_01',
        type: TransactionType.income,
      ),
    ),
  ],
);

