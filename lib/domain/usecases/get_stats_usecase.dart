// lib/domain/usecases/get_stats_usecase.dart
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';

class GetStatsUseCase {
  final TransactionRepository repository;
  GetStatsUseCase(this.repository);

  Future<Map<TransactionType, double>> execute() async {
    final transactions = await repository.getAllTransactions();
    double income = 0;
    double expense = 0;

    for (var tx in transactions) {
      if (tx.type == TransactionType.income) income += tx.amount;
      else expense += tx.amount;
    }
    return {TransactionType.income: income, TransactionType.expense: expense};
  }
}