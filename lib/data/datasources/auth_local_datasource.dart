// // Слой: data | Назначение: локальный источник данных авторизации (Drift + SharedPreferences)

// import 'package:drift/drift.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../core/constants/app_constants.dart';
// import '../../domain/entities/user.dart';
// import 'app_database.dart' hide User;

// class AuthLocalDatasource {
//   AuthLocalDatasource(this._db);
//   final AppDatabase _db;

//   // Регистрация: создаёт запись в таблице Users
//   Future<User> register({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     final existing = await (_db.select(_db.users)
//           ..where((u) => u.email.equals(email)))
//         .getSingleOrNull();

//     if (existing != null) {
//       throw Exception('Пользователь с email $email уже существует');
//     }

//     final id = await _db.into(_db.users).insert(
//           UsersCompanion.insert(
//             name: name,
//             email: email,
//             password: password,
//             createdAt: DateTime.now(),
//           ),
//         );

//     final userData = await (_db.select(_db.users)
//           ..where((u) => u.id.equals(id)))
//         .getSingle();

//     return userData.toEntity();
//   }

//   // Вход: проверяет email + пароль
//   Future<User> login({
//     required String email,
//     required String password,
//   }) async {
//     final userData = await (_db.select(_db.users)
//           ..where((u) => u.email.equals(email)))
//         .getSingleOrNull();

//     if (userData == null) {
//       throw Exception('Пользователь не найден');
//     }

//     if (userData.password != password) {
//       throw Exception('Неверный пароль');
//     }

//     return userData.toEntity();
//   }

//   // Сохранение сессии в SharedPreferences
//   Future<void> saveSession(User user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(AppConstants.kSessionKey, user.id);
//     await prefs.setString(AppConstants.kUserEmailKey, user.email);
//   }

//   // Чтение сессии при запуске приложения
//   Future<User?> loadSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getInt(AppConstants.kSessionKey);

//     if (userId == null) return null;

//     final userData = await (_db.select(_db.users)
//           ..where((u) => u.id.equals(userId)))
//         .getSingleOrNull();

//     return userData?.toEntity();
//   }

//   // Очистка сессии при выходе
//   Future<void> clearSession() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(AppConstants.kSessionKey);
//     await prefs.remove(AppConstants.kUserEmailKey);
//   }
// }



import 'package:fintrack/data/models/user_model.dart';
import 'package:hive/hive.dart';


abstract class AuthLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final String boxName = 'user_box';

  Box _box() => Hive.box(boxName);

  @override
  Future<void> saveUser(UserModel user) async {
    // User-ды JSON ретінде сақтау Hive үшін оңайырақ
    await _box().put('current_user', user.toJson());
  }

  @override
  Future<UserModel?> getUser() async {
    final userData = _box().get('current_user');
    if (userData != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userData));
    }
    return null;
  }

  @override
  Future<void> clear() async {
    await _box().delete('current_user');
  }
}
