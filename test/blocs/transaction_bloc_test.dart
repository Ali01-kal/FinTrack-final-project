import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_event.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late _MockTransactionRepository repository;

  final tx = TransactionEntity(
    id: '1',
    title: 'Salary',
    amount: 1000,
    date: DateTime(2026, 1, 1),
    categoryId: 'income',
    type: TransactionType.income,
  );

  setUp(() {
    repository = _MockTransactionRepository();
  });

  blocTest<TransactionBloc, TransactionState>(
    'emits [Loading, Loaded] on successful LoadTransactions',
    build: () {
      when(() => repository.getAllTransactions()).thenAnswer((_) async => <TransactionEntity>[tx]);
      return TransactionBloc(repository: repository);
    },
    act: (bloc) => bloc.add(LoadTransactions()),
    expect: () => <TypeMatcher<TransactionState>>[
      isA<TransactionLoading>(),
      isA<TransactionLoaded>(),
    ],
    verify: (_) {
      verify(() => repository.getAllTransactions()).called(1);
    },
  );

  blocTest<TransactionBloc, TransactionState>(
    'emits [Loading, Error] when LoadTransactions fails',
    build: () {
      when(() => repository.getAllTransactions()).thenThrow(Exception('db fail'));
      return TransactionBloc(repository: repository);
    },
    act: (bloc) => bloc.add(LoadTransactions()),
    expect: () => <TypeMatcher<TransactionState>>[
      isA<TransactionLoading>(),
      isA<TransactionError>(),
    ],
  );

  blocTest<TransactionBloc, TransactionState>(
    'AddTransaction triggers add + reload',
    build: () {
      when(() => repository.addTransaction(tx)).thenAnswer((_) async {});
      when(() => repository.getAllTransactions()).thenAnswer((_) async => <TransactionEntity>[tx]);
      return TransactionBloc(repository: repository);
    },
    act: (bloc) => bloc.add(AddTransaction(tx)),
    expect: () => <TypeMatcher<TransactionState>>[
      isA<TransactionLoading>(),
      isA<TransactionLoaded>(),
    ],
    verify: (_) {
      verify(() => repository.addTransaction(tx)).called(1);
      verify(() => repository.getAllTransactions()).called(1);
    },
  );
}
