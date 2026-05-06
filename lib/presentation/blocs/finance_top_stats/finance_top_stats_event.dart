import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class FinanceTopStatsEvent {}

class FinanceTopStatsSyncRequested extends FinanceTopStatsEvent {
  FinanceTopStatsSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}
