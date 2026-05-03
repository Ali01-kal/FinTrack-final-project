import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getAllTransactions();
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(String id);
  Future<List<TransactionEntity>> filterByCategory(String categoryId);
  Future<List<TransactionEntity>> searchTransactions(String query);
  Future<List<TransactionEntity>> filterByDateRange(DateTime start, DateTime end);
}