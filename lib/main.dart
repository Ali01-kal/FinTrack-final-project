import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'package:fintrack/data/models/transaction_model.dart';

// DI & Router
import 'core/di/injection_container.dart' as di;
import 'package:fintrack/core/router/app_router.dart';

// Blocs
import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/auth/auth_event.dart';
import 'package:fintrack/presentation/blocs/export/bloc/export_bloc.dart';
import 'package:fintrack/presentation/blocs/home/bloc/home_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_event.dart';

// Core Assets
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  await Hive.openBox<TransactionModel>(AppConstants.kTransactionsBox);
  await Hive.openBox(AppConstants.kUserBox);
  await NotificationService.init();
  final userBox = Hive.box(AppConstants.kUserBox);
  final reminderEnabled = userBox.get(
    AppConstants.kExpenseReminderEnabledKey,
    defaultValue: false,
  ) as bool;
  if (reminderEnabled) {
    await NotificationService.scheduleDailyExpenseReminder();
  }

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
        
        BlocProvider(create: (_) => di.sl<ThemeBloc>()),
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider(create: (_) => di.sl<TransactionBloc>()..add(LoadTransactions())),
        BlocProvider(create: (_) => di.sl<HomeBloc>()..add(HomeLoadRequested())),
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
