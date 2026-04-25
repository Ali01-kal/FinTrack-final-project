import '../entities/transaction_entity.dart'; // Егер кейін керек болса

abstract class AuthRepository {
  // Тіркелу
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });

  // Кіру
  Future<void> login({
    required String email,
    required String password,
  });

  // Шығу
  Future<void> logout();

  // Сессияны тексеру
  Future<bool> isAuthenticated();
}