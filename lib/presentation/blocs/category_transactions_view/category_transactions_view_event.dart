import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class CategoryTransactionsViewEvent {}

class CategoryTransactionsSyncRequested extends CategoryTransactionsViewEvent {
  CategoryTransactionsSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}
