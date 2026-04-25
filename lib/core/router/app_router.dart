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



import 'package:fintrack/presentation/auth/welcome_screen.dart';
import 'package:fintrack/presentation/splash/splash_screen.dart';
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
      path: AppConstants.routeAnalytics,
      builder: (context, state) => const StatisticsScreen(),
    ),
  ],
);