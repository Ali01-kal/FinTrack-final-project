import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user != null 
        ? UserModel(id: userCredential.user!.uid, email: email) 
        : null;
  }

  @override
  Future<UserModel?> signUp(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user != null 
        ? UserModel(id: userCredential.user!.uid, email: email) 
        : null;
  }

  @override
  Future<void> signOut() async => await _firebaseAuth.signOut();

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserModel(id: user.uid, email: user.email!) : null;
  }
}