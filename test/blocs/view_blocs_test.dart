import 'package:bloc_test/bloc_test.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/categories_view/categories_view_bloc.dart';
import 'package:fintrack/presentation/blocs/categories_view/categories_view_event.dart';
import 'package:fintrack/presentation/blocs/categories_view/categories_view_state.dart';
import 'package:fintrack/presentation/blocs/transactions_view/transactions_view_bloc.dart';
import 'package:fintrack/presentation/blocs/transactions_view/transactions_view_event.dart';
import 'package:fintrack/presentation/blocs/transactions_view/transactions_view_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final txs = <TransactionEntity>[
    TransactionEntity(
      id: '1',
      title: 'Salary',
      amount: 1000,
      date: DateTime(2026, 1, 1, 8),
      categoryId: 'income',
      type: TransactionType.income,
    ),
    TransactionEntity(
      id: '2',
      title: 'Food',
      amount: 150,
      date: DateTime(2026, 1, 2, 10),
      categoryId: 'food',
      type: TransactionType.expense,
    ),
  ];

  blocTest<CategoriesViewBloc, CategoriesViewState>(
    'CategoriesViewSyncRequested computes summary',
    build: () => CategoriesViewBloc(),
    act: (bloc) => bloc.add(CategoriesViewSyncRequested(txs)),
    verify: (bloc) {
      expect(bloc.state.income, 1000);
      expect(bloc.state.expense, 150);
      expect(bloc.state.balance, 850);
      expect(bloc.state.progress, 0.15);
    },
  );

  blocTest<TransactionsViewBloc, TransactionsViewState>(
    'TransactionsViewSyncRequested computes totals and sorted list',
    build: () => TransactionsViewBloc(),
    act: (bloc) => bloc.add(TransactionsViewSyncRequested(txs)),
    verify: (bloc) {
      expect(bloc.state.incomeTotal, 1000);
      expect(bloc.state.expenseTotal, 150);
      expect(bloc.state.filtered.length, 2);
      expect(bloc.state.filtered.first.id, '2');
    },
  );

  blocTest<TransactionsViewBloc, TransactionsViewState>(
    'TransactionsFilterChanged applies expense filter',
    build: () => TransactionsViewBloc(),
    seed: () => const TransactionsViewState(
      activeFilter: 0,
      incomeTotal: 0,
      expenseTotal: 0,
      balance: 0,
      filtered: <TransactionEntity>[],
    ),
    act: (bloc) {
      bloc.add(TransactionsViewSyncRequested(txs));
      bloc.add(TransactionsFilterChanged(2));
    },
    verify: (bloc) {
      expect(bloc.state.activeFilter, 2);
      expect(bloc.state.filtered.length, 1);
      expect(bloc.state.filtered.first.type, TransactionType.expense);
    },
  );
}
