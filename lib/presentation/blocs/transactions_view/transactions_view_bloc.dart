import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions_view_event.dart';
import 'transactions_view_state.dart';

class TransactionsViewBloc
    extends Bloc<TransactionsViewEvent, TransactionsViewState> {
  TransactionsViewBloc() : super(TransactionsViewState.initial()) {
    on<TransactionsViewSyncRequested>(_onSyncRequested);
    on<TransactionsFilterChanged>(_onFilterChanged);
  }

  List<TransactionEntity> _all = <TransactionEntity>[];

  void _onSyncRequested(
    TransactionsViewSyncRequested event,
    Emitter<TransactionsViewState> emit,
  ) {
    _all = event.transactions;
    emit(_buildState(activeFilter: state.activeFilter));
  }

  void _onFilterChanged(
    TransactionsFilterChanged event,
    Emitter<TransactionsViewState> emit,
  ) {
    final next = state.activeFilter == event.filterIndex ? 0 : event.filterIndex;
    emit(_buildState(activeFilter: next));
  }

  TransactionsViewState _buildState({required int activeFilter}) {
    final incomeTotal = _all
        .where((tx) => tx.type == TransactionType.income)
        .fold<double>(0, (sum, tx) => sum + tx.amount);
    final expenseTotal = _all
        .where((tx) => tx.type == TransactionType.expense)
        .fold<double>(0, (sum, tx) => sum + tx.amount);
    final balance = incomeTotal - expenseTotal;
    final filtered = activeFilter == 1
        ? _all.where((tx) => tx.type == TransactionType.income).toList()
        : activeFilter == 2
            ? _all.where((tx) => tx.type == TransactionType.expense).toList()
            : <TransactionEntity>[..._all];
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return TransactionsViewState(
      activeFilter: activeFilter,
      incomeTotal: incomeTotal,
      expenseTotal: expenseTotal,
      balance: balance,
      filtered: filtered,
    );
  }
}
