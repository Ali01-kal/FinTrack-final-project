import 'package:fintrack/domain/entities/transaction_entity.dart';

class CategoryTransactionsViewState {
  const CategoryTransactionsViewState({
    required this.items,
  });

  final List<TransactionEntity> items;

  factory CategoryTransactionsViewState.initial() =>
      const CategoryTransactionsViewState(items: <TransactionEntity>[]);
}
