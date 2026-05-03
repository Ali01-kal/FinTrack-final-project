import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart'; 
import 'base_usecase.dart';

class AddTransactionUseCase implements BaseUseCase<void, TransactionEntity> {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  @override
  Future<void> execute(TransactionEntity transaction) async {
    return await repository.addTransaction(transaction);
  }
}