import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

// DI & Router
import 'core/di/injection_container.dart' as di;
import 'package:fintrack/core/router/app_router.dart';

// Blocs
import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/auth/auth_event.dart';
import 'package:fintrack/presentation/blocs/export/bloc/export_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';

// Core Assets
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.kUserBox);
  
  // 1. DI инициализациясы (Міндетті)
  await di.init();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase connected successfully!");
  } catch (e) {
    print("Firebase error: $e");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Барлығын DI (Service Locator) арқылы шақырамыз
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider(create: (_) => di.sl<TransactionBloc>()),
        BlocProvider(create: (_) => di.sl<StatisticsBloc>()),
        BlocProvider(create: (_) => di.sl<ExportBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'FinTrack',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            routerConfig: appRouter, 
          );
        },
      ),
    );
  }
}
