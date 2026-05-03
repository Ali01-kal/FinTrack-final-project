// Слой: domain | Назначение: базовый абстрактный класс use case

import 'package:dartz/dartz.dart'; // Failure немесе Success қайтару үшін ыңғайлы

abstract class BaseUseCase<Type, Params> {
  Future<Type> execute(Params params);
}

class NoParams {}