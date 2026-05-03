import 'package:hive/hive.dart';
import '../../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getCachedTransactions();
  Future<void> cacheTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
  Future<void> updateTransaction(TransactionModel transaction); // Жаңарту функциясы
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final String boxName = 'transactions_box';

  @override
  Future<List<TransactionModel>> getCachedTransactions() async {
    final box = await Hive.openBox<TransactionModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> cacheTransaction(TransactionModel transaction) async {
    final box = await Hive.openBox<TransactionModel>(boxName);
    await box.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final box = await Hive.openBox<TransactionModel>(boxName);
    await box.delete(id);
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    final box = await Hive.openBox<TransactionModel>(boxName);
    if (box.containsKey(transaction.id)) {
      await box.put(transaction.id, transaction);
    }
  }
}