// // Слой: domain | Назначение: use case проверки сохранённой сессии при старте приложения

import 'package:fintrack/domain/entities/user_entity.dart';
import 'package:fintrack/domain/repositories/auth_repository.dart';

import 'base_usecase.dart';

class CheckSessionUseCase implements BaseUseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  CheckSessionUseCase(this.repository);

  @override
  Future<UserEntity?> execute(NoParams params) async {
    return await repository.getCurrentUser();
  }
}