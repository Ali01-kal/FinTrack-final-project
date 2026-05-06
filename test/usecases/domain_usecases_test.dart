import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/entities/user_entity.dart';
import 'package:fintrack/domain/repositories/auth_repository.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:fintrack/domain/usecases/add_transaction_usecase.dart';
import 'package:fintrack/domain/usecases/base_usecase.dart';
import 'package:fintrack/domain/usecases/check_session_usecase.dart';
import 'package:fintrack/domain/usecases/get_stats_usecase.dart';
import 'package:fintrack/domain/usecases/get_transactions_usecase.dart';
import 'package:fintrack/domain/usecases/login_usecase.dart';
import 'package:fintrack/domain/usecases/register_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  group('Domain UseCases', () {
    late MockAuthRepository authRepository;
    late MockTransactionRepository transactionRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      transactionRepository = MockTransactionRepository();
    });

    test('LoginUseCase should call signIn and return user', () async {
      final useCase = LoginUseCase(authRepository);
      final params = LoginParams(email: 'mark@mail.com', password: '123456');
      final user = UserEntity(id: 'u1', email: 'mark@mail.com', name: 'Mark');

      when(() => authRepository.signIn(params.email, params.password)).thenAnswer((_) async => user);

      final result = await useCase.execute(params);

      expect(result, user);
      verify(() => authRepository.signIn(params.email, params.password)).called(1);
      verifyNoMoreInteractions(authRepository);
    });

    test('RegisterUseCase should call signUp and return user', () async {
      final useCase = RegisterUseCase(authRepository);
      final params = RegisterParams(email: 'new@mail.com', password: 'abc12345');
      final user = UserEntity(id: 'u2', email: 'new@mail.com');

      when(() => authRepository.signUp(params.email, params.password)).thenAnswer((_) async => user);

      final result = await useCase.execute(params);

      expect(result?.email, 'new@mail.com');
      verify(() => authRepository.signUp(params.email, params.password)).called(1);
      verifyNoMoreInteractions(authRepository);
    });

    test('CheckSessionUseCase should return current user from repository', () async {
      final useCase = CheckSessionUseCase(authRepository);
      final user = UserEntity(id: 'u3', email: 'session@mail.com');

      when(() => authRepository.getCurrentUser()).thenAnswer((_) async => user);

      final result = await useCase.execute( NoParams());

      expect(result?.id, 'u3');
      verify(() => authRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(authRepository);
    });

    test('GetTransactionsUseCase should return all transactions', () async {
      final useCase = GetTransactionsUseCase(transactionRepository);
      final transactions = <TransactionEntity>[
        TransactionEntity(
          id: 't1',
          title: 'Salary',
          amount: 2000,
          date: DateTime(2026, 1, 10),
          categoryId: 'income',
          type: TransactionType.income,
        ),
        TransactionEntity(
          id: 't2',
          title: 'Food',
          amount: 120,
          date: DateTime(2026, 1, 11),
          categoryId: 'food',
          type: TransactionType.expense,
        ),
      ];

      when(() => transactionRepository.getAllTransactions()).thenAnswer((_) async => transactions);

      final result = await useCase.execute();

      expect(result.length, 2);
      expect(result.first.title, 'Salary');
      verify(() => transactionRepository.getAllTransactions()).called(1);
      verifyNoMoreInteractions(transactionRepository);
    });

    test('GetStatsUseCase should aggregate income and expense totals', () async {
      final useCase = GetStatsUseCase(transactionRepository);
      final transactions = <TransactionEntity>[
        TransactionEntity(
          id: 't1',
          title: 'Salary',
          amount: 3000,
          date: DateTime(2026, 1, 1),
          categoryId: 'income',
          type: TransactionType.income,
        ),
        TransactionEntity(
          id: 't2',
          title: 'Bonus',
          amount: 500,
          date: DateTime(2026, 1, 2),
          categoryId: 'income',
          type: TransactionType.income,
        ),
        TransactionEntity(
          id: 't3',
          title: 'Rent',
          amount: 900,
          date: DateTime(2026, 1, 3),
          categoryId: 'rent',
          type: TransactionType.expense,
        ),
      ];

      when(() => transactionRepository.getAllTransactions()).thenAnswer((_) async => transactions);

      final result = await useCase.execute();

      expect(result[TransactionType.income], 3500);
      expect(result[TransactionType.expense], 900);
      verify(() => transactionRepository.getAllTransactions()).called(1);
      verifyNoMoreInteractions(transactionRepository);
    });

    test('AddTransactionUseCase should call repository.addTransaction once', () async {
      final useCase = AddTransactionUseCase(transactionRepository);
      final tx = TransactionEntity(
        id: 't100',
        title: 'Taxi',
        amount: 15,
        date: DateTime(2026, 2, 1),
        categoryId: 'transport',
        type: TransactionType.expense,
      );

      when(() => transactionRepository.addTransaction(tx)).thenAnswer((_) async {});

      await useCase.execute(tx);

      verify(() => transactionRepository.addTransaction(tx)).called(1);
      verifyNoMoreInteractions(transactionRepository);
    });
  });
}
