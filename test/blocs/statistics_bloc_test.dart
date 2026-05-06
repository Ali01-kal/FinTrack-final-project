import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_event.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTransactionRepository extends Mock implements TransactionRepository {}

void main() {
  late _MockTransactionRepository repository;

  final txs = <TransactionEntity>[
    TransactionEntity(
      id: 'i1',
      title: 'Salary',
      amount: 2000,
      date: DateTime(2026, 1, 10),
      categoryId: 'income',
      type: TransactionType.income,
    ),
    TransactionEntity(
      id: 'e1',
      title: 'Food',
      amount: 200,
      date: DateTime(2026, 1, 11),
      categoryId: 'food',
      type: TransactionType.expense,
    ),
  ];

  setUp(() {
    repository = _MockTransactionRepository();
  });

  blocTest<StatisticsBloc, StatisticsState>(
    'LoadStatistics emits [Loading, Loaded] with computed totals',
    build: () {
      when(() => repository.getAllTransactions()).thenAnswer((_) async => txs);
      return StatisticsBloc(repository: repository);
    },
    act: (bloc) => bloc.add(
      LoadStatistics(
        startDate: DateTime(2026, 1, 1),
        endDate: DateTime(2026, 1, 31),
      ),
    ),
    expect: () => <TypeMatcher<StatisticsState>>[
      isA<StatisticsLoading>(),
      isA<StatisticsLoaded>(),
    ],
    verify: (bloc) {
      final state = bloc.state as StatisticsLoaded;
      expect(state.totalIncome, 2000);
      expect(state.totalExpense, 200);
      expect(state.totalBalance, 1800);
      expect(state.selectedPeriod, 'Custom');
      verify(() => repository.getAllTransactions()).called(1);
    },
  );

  blocTest<StatisticsBloc, StatisticsState>(
    'LoadStatistics emits [Loading, Error] when repository throws',
    build: () {
      when(() => repository.getAllTransactions()).thenThrow(Exception('boom'));
      return StatisticsBloc(repository: repository);
    },
    act: (bloc) => bloc.add(LoadStatistics()),
    expect: () => <TypeMatcher<StatisticsState>>[
      isA<StatisticsLoading>(),
      isA<StatisticsError>(),
    ],
  );
}
