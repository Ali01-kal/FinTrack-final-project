// import 'package:fintrack/presentation/auth/register_screen.dart';
// import 'package:fintrack/presentation/screens/register_screen.dart';
// import 'package:fintrack/presentation/screens/splash_screen.dart';
// import 'package:fintrack/presentation/splash/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// // Қажетті тұрақты мәндер мен Bloc-ты импорттау
// import '../../core/constants/app_constants.dart';
// import '../../presentation/blocs/auth/auth_bloc.dart';

// // ЖАҢА ПАПКАЛАРДАН ЭКРАНДАРДЫ ИМПОРТТАУ
// import '../../presentation/auth/login_screen.dart';

// import '../../presentation/home/home_screen.dart';
// import '../../presentation/statistics/statistics_screen.dart'; 

// GoRouter createRouter(AuthBloc authBloc) {
//   return GoRouter(
//     initialLocation: AppConstants.routeSplash,
//     refreshListenable: _AuthStateListenable(authBloc),
//     redirect: (BuildContext context, GoRouterState state) {
//       final authState = authBloc.state;
      
//       // Бағыттарды анықтау
//       final isAuthRoute = state.matchedLocation == AppConstants.routeLogin ||
//           state.matchedLocation == AppConstants.routeRegister;
//       final isSplash = state.matchedLocation == AppConstants.routeSplash;

//       // 1. Жүктелу күйі: Splash-те қалу
//       if (authState is AuthLoading || authState is AuthInitial) {
//         return isSplash ? null : AppConstants.routeSplash;
//       }

//       // 2. Авторизацияланған: Home-ға бағыттау
//       if (authState is AuthAuthenticated) {
//         return isAuthRoute || isSplash ? AppConstants.routeHome : null;
//       }

//       // 3. Авторизацияланбаған: Login-ге бағыттау
//       if (authState is AuthUnauthenticated) {
//         return isAuthRoute ? null : AppConstants.routeLogin;
//       }

//       return null;
//     },
//     routes: [
//       GoRoute(
//         path: AppConstants.routeSplash,
//         builder: (context, state) => const SplashScreen(),
//       ),
//       GoRoute(
//         path: AppConstants.routeLogin,
//         builder: (context, state) => const LoginScreen(),
//       ),
//       GoRoute(
//         path: AppConstants.routeRegister,
//         builder: (context, state) => const RegisterScreen(),
//       ),
//       GoRoute(
//         path: AppConstants.routeHome,
//         builder: (context, state) => const HomeScreen(),
//       ),
//       GoRoute(
//         path: AppConstants.routeAnalytics, // Бұл жерде AppConstants.routeAnalytics қолданылған
//         builder: (context, state) => const StatisticsScreen(),
//       ),
//     ],
//   );
// }

// // Bloc күйі өзгергенде навигацияны жаңарту үшін қажет
// class _AuthStateListenable extends ChangeNotifier {
//   _AuthStateListenable(this._authBloc) {
//     _authBloc.stream.listen((_) => notifyListeners());
//   }

//   final AuthBloc _authBloc;
// }



import 'package:fintrack/presentation/account/account_balance.dart';
import 'package:fintrack/presentation/analysis/analysis_screen.dart';
import 'package:fintrack/presentation/analysis/calendar_screen.dart';
import 'package:fintrack/presentation/analysis/quikly_analysis_screen.dart';
import 'package:fintrack/presentation/analysis/search_screen.dart';
import 'package:fintrack/presentation/auth/welcome_screen.dart';
import 'package:fintrack/presentation/categories/add_expences.dart';
import 'package:fintrack/presentation/categories/add_savings_screen.dart';
import 'package:fintrack/presentation/categories/car_detail_screen.dart';
import 'package:fintrack/presentation/categories/categories_screen.dart';
import 'package:fintrack/presentation/categories/entartainment_screen.dart';
import 'package:fintrack/presentation/categories/food_screen.dart';
import 'package:fintrack/presentation/categories/gifts_screen.dart';
import 'package:fintrack/presentation/categories/groceries_screen.dart';
import 'package:fintrack/presentation/categories/medicine_screen.dart';
import 'package:fintrack/presentation/categories/new_house_detail_screen.dart';
import 'package:fintrack/presentation/categories/rent_screen.dart';
import 'package:fintrack/presentation/categories/saving_screen.dart';
import 'package:fintrack/presentation/categories/transport_screen.dart';
import 'package:fintrack/presentation/categories/travel_detail_screen.dart';
import 'package:fintrack/presentation/categories/wedding_detail_screen.dart';
import 'package:fintrack/presentation/notifications/notifications_screen.dart';
import 'package:fintrack/presentation/profile/delete_account_screen.dart';
import 'package:fintrack/presentation/profile/edit_profile_screen.dart';
import 'package:fintrack/presentation/profile/help_center_screen.dart';
import 'package:fintrack/presentation/profile/notification_settings_screen.dart';
import 'package:fintrack/presentation/profile/password_settings_screen.dart';
import 'package:fintrack/presentation/profile/profile_screen.dart';
import 'package:fintrack/presentation/profile/settings_screen.dart';
import 'package:fintrack/presentation/splash/splash_screen.dart';
import 'package:fintrack/presentation/transactions/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/auth/register_screen.dart';

import '../../presentation/home/home_screen.dart';
import '../../presentation/statistics/statistics_screen.dart';

// Блоксыз қарапайым роутер
final AppRouter = GoRouter(
  initialLocation: AppConstants.routeSplash,
  routes: [
    GoRoute(
      path: AppConstants.routeWelcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppConstants.routeSplash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppConstants.routeLogin,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppConstants.routeRegister,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppConstants.routeHome,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppConstants.routeNotifications,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: AppConstants.routeAccountBalance,
      builder: (context, state) => const AccountBalanceScreen(),
    ),
    GoRoute(
      path: AppConstants.routeQuiklyAnalytics,
      builder: (context, state) => const QuiklyAnalysisScreen(),
    ),
    GoRoute(
      path: AppConstants.routeAnalysis,
      builder: (context, state) => const AnalysisScreen(),
    ),
    GoRoute(
      path: AppConstants.routeSearch,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: AppConstants.routeCalendar,
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: AppConstants.routeTransaction,
      builder: (context, state) => const TransactionScreen(),
    ),
    GoRoute(
      path: AppConstants.routeCategories,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: AppConstants.routeFood,
      builder: (context, state) => const FoodScreen(),
    ),
    GoRoute(
      path: AppConstants.routeAddExpences,
      builder: (context, state) => const AddExpenseScreen() ,
    ),
    GoRoute(
      path: AppConstants.routeTransport,
      builder: (context, state) => const TransportScreen(),
    ),
    GoRoute(
      path: AppConstants.routeGroceries,
      builder: (context, state) => const GroceriesScreen(),
    ),
    GoRoute(
      path: AppConstants.routeRent,
      builder: (context, state) => const RentScreen(),
    ),
    GoRoute(
      path: AppConstants.routeGifts,
      builder: (context, state) => const GiftsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeMedicine,
      builder: (context, state) => const MedicineScreen(),
    ),
    GoRoute(
      path: AppConstants.routeEntertainment,
      builder: (context, state) => const EntertainmentScreen(),
    ),
    GoRoute(
      path: AppConstants.routeSaving,
      builder: (context, state) => const SavingsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeDetailTravel,
      builder: (context, state) => const TravelDetailScreen(),
    ),
    GoRoute(
      path: AppConstants.routeAddSavings,
      builder: (context, state) => const AddSavingsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeNewHouse,
      builder: (context, state) => const NewHouseDetailScreen(),
    ),
    GoRoute(
      path: AppConstants.routeCarDetail,
      builder: (context, state) => const CarDetailScreen(),
    ),
    GoRoute(
      path: AppConstants.routeWeddingDetail,
      builder: (context, state) => const WeddingDetailScreen(),
    ),
    GoRoute(
      path: AppConstants.routeProfile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppConstants.routeEditProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppConstants.routeSettings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeNotificationSettings,
      builder: (context, state) => const NotificationSettingsScreen(),
    ),
    GoRoute(
      path: AppConstants.routePasswordSettings,
      builder: (context, state) => const PasswordSettingsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeDeleteAccount,
      builder: (context, state) => const DeleteAccountScreen(),
    ),
    GoRoute(
      path: AppConstants.routeHelpCenter,
      builder: (context, state) => const HelpCenterScreen(),
    ),
  ],
);