import 'package:fintrack/domain/entities/transaction_entity.dart';

class TransactionsViewState {
  const TransactionsViewState({
    required this.activeFilter,
    required this.incomeTotal,
    required this.expenseTotal,
    required this.balance,
    required this.filtered,
  });

  final int activeFilter;
  final double incomeTotal;
  final double expenseTotal;
  final double balance;
  final List<TransactionEntity> filtered;

  factory TransactionsViewState.initial() => const TransactionsViewState(
        activeFilter: 0,
        incomeTotal: 0,
        expenseTotal: 0,
        balance: 0,
        filtered: <TransactionEntity>[],
      );
}
