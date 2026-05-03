
import 'package:fintrack/domain/entities/user_entity.dart';
import 'package:fintrack/domain/repositories/auth_repository.dart';
import 'base_usecase.dart';

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}

class LoginUseCase implements BaseUseCase<UserEntity?, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<UserEntity?> execute(LoginParams params) async {
    return await repository.signIn(params.email, params.password);
  }
}