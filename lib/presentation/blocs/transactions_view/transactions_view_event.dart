import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class TransactionsViewEvent {}

class TransactionsViewSyncRequested extends TransactionsViewEvent {
  TransactionsViewSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}

class TransactionsFilterChanged extends TransactionsViewEvent {
  TransactionsFilterChanged(this.filterIndex);
  final int filterIndex;
}
