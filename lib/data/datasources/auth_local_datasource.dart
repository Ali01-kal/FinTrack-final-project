// // Слой: data | Назначение: локальный источник данных авторизации (Drift + SharedPreferences)

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
