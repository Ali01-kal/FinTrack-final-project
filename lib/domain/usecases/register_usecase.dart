import 'package:fintrack/domain/entities/user_entity.dart';
import 'package:fintrack/domain/repositories/auth_repository.dart';
import 'base_usecase.dart';

class RegisterParams {
  final String email;
  final String password;
  RegisterParams({required this.email, required this.password});
}

class RegisterUseCase implements BaseUseCase<UserEntity?, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<UserEntity?> execute(RegisterParams params) async {
    return await repository.signUp(params.email, params.password);
  }
}