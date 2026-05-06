import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class SavingsGoalViewEvent {}

class SavingsGoalSyncRequested extends SavingsGoalViewEvent {
  SavingsGoalSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}
