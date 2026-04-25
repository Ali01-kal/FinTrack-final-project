import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getAllTransactions();
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(String id);
  Future<void> updateTransaction(TransactionEntity transaction);
}