import 'package:fintrack/data/datasources/local/transaction_local_data_source.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';

import '../models/transaction_model.dart';
import 'package:uuid/uuid.dart'; // ID генерациясы үшін

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;
  final _uuid = const Uuid();

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    // Hive-тан моделдерді аламыз және оларды Entity-ге айналдырамыз
    final models = await localDataSource.getCachedTransactions();
    return models; // TransactionModel қазірдің өзінде TransactionEntity-ден мұраланған
  }

  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    // Егер ID бос болса, жаңа ID береміз (Uuid)
    final id = transaction.id.isEmpty ? _uuid.v4() : transaction.id;
    
    final model = TransactionModel.fromEntity(transaction).copyWithId(id);
    await localDataSource.cacheTransaction(model);
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await localDataSource.updateTransaction(model);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await localDataSource.deleteTransaction(id);
  }

  @override
  Future<List<TransactionEntity>> searchTransactions(String query) async {
    final all = await getAllTransactions();
    return all.where((tx) => 
      tx.title.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<List<TransactionEntity>> filterByDateRange(DateTime start, DateTime end) async {
    final all = await getAllTransactions();
    return all.where((tx) => 
      tx.date.isAfter(start) && tx.date.isBefore(end)).toList();
  }

  @override
  Future<List<TransactionEntity>> filterByCategory(String categoryId) async {
    final all = await getAllTransactions();
    return all.where((tx) => tx.categoryId == categoryId).toList();
  }
}