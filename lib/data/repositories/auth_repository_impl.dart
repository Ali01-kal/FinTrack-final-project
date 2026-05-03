// // Слой: data | Назначение: реализация AuthRepository через локальные источники данных

// import '../../domain/entities/user.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../datasources/auth_local_datasource.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   AuthRepositoryImpl(this._localDatasource);

//   final AuthLocalDatasource _localDatasource;

//   @override
//   Future<User> login({required String email, required String password}) async {
//     final user = await _localDatasource.login(email: email, password: password);
//     await _localDatasource.saveSession(user);
//     return user;
//   }

//   @override
//   Future<User> register({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     final user = await _localDatasource.register(
//       name: name,
//       email: email,
//       password: password,
//     );
//     await _localDatasource.saveSession(user);
//     return user;
//   }

//   @override
//   Future<User?> checkSession() {
//     return _localDatasource.loadSession();
//   }

//   @override
//   Future<void> logout() {
//     return _localDatasource.clearSession();
//   }
// }
import 'package:fintrack/data/datasources/auth_local_datasource.dart';
import 'package:fintrack/data/datasources/remote/auth_remote_data_source.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    final userModel = await remoteDataSource.signIn(email, password);
    if (userModel != null) {
      await localDataSource.saveUser(userModel);
    }
    return userModel;
  }

  @override
  Future<UserEntity?> signUp(String email, String password) async {
    final userModel = await remoteDataSource.signUp(email, password);
    if (userModel != null) {
      await localDataSource.saveUser(userModel);
    }
    return userModel;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
    await localDataSource.clear();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // Алдымен Hive-тан (local) тексереміз, бұл жылдамырақ
    final localUser = await localDataSource.getUser();
    if (localUser != null) return localUser;

    // Егер жоқ болса, Firebase-тен (remote) тексереміз
    final remoteUser = await remoteDataSource.getCurrentUser();
    if (remoteUser != null) {
      await localDataSource.saveUser(remoteUser);
    }
    return remoteUser;
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    // Бұл жерде Firebase-тің өзіндік Stream-ін қайтаруға болады
    // Бірақ қазірше MVP үшін қарапайым нұсқасын қалдырайық
    throw UnimplementedError();
  }
}