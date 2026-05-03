import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';


class GetTransactionsUseCase {
  final TransactionRepository repository;
  GetTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> execute() {
    return repository.getAllTransactions();
  }
}