import 'package:fintrack/domain/entities/transaction_entity.dart';


abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final TransactionEntity transaction;
  AddTransaction(this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final String id;
  DeleteTransaction(this.id);
}

class UpdateTransaction extends TransactionEvent {
  final TransactionEntity transaction;
  UpdateTransaction(this.transaction);
}