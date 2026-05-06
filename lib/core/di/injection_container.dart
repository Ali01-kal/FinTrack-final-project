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
import 'package:fintrack/presentation/blocs/home/bloc/home_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(() => TransactionBloc(repository: sl()));
  sl.registerFactory(() => HomeBloc(repository: sl()));
  sl.registerFactory(() => StatisticsBloc(repository: sl()));
  sl.registerFactory(() => ExportBloc(repository: sl()));


  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()), 
  );

  sl.registerLazySingleton<GoRouter>(() => appRouter);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()), 
  );
  
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<TransactionLocalDataSource>(
    () => TransactionLocalDataSourceImpl(),
  );


  sl.registerLazySingleton(() => FirebaseAuth.instance);

}
