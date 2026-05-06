import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn(String email, String password);
  Future<UserEntity?> signUp(String email, String password);
  Future<UserEntity?> updateCurrentUser(UserEntity user);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> get authStateChanges;
}
