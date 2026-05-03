import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Router
import 'package:fintrack/core/router/app_router.dart';
import 'package:go_router/go_router.dart';

// Data Sources
import 'package:fintrack/data/datasources/auth_local_datasource.dart';
import 'package:fintrack/data/datasources/local/transaction_local_data_source.dart';
import 'package:fintrack/data/datasources/remote/auth_remote_data_source.dart';

// Repositories
import 'package:fintrack/data/repositories/auth_repository_impl.dart';
import 'package:fintrack/data/repositories/transaction_repository_impl.dart';
import 'package:fintrack/domain/repositories/auth_repository.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';

// Blocs
import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/export/bloc/export_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! 1. Блоктар (Factory - әр шақырғанда жаңа инстанс)
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => TransactionBloc(repository: sl()));
  sl.registerFactory(() => StatisticsBloc(repository: sl()));
  sl.registerFactory(() => ExportBloc(repository: sl()));

  //! 2. Репозиторийлер (LazySingleton)
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()), // LocalDataSource-ты sl() арқылы береді
  );

  sl.registerLazySingleton<GoRouter>(() => appRouter);

  //! 3. Деректер көздері
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()), // FirebaseAuth береді
  );
  
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(),
  );

  //! 4. Сыртқы библиотекалар
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  // sl.registerLazySingleton(() => FirebaseFirestore.instance);
}