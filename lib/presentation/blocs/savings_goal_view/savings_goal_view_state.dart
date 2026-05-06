import 'package:fintrack/domain/entities/transaction_entity.dart';

class SavingsGoalViewState {
  const SavingsGoalViewState({
    required this.items,
    required this.saved,
    required this.progress,
  });

  final List<TransactionEntity> items;
  final double saved;
  final double progress;

  factory SavingsGoalViewState.initial() => const SavingsGoalViewState(
        items: <TransactionEntity>[],
        saved: 0,
        progress: 0,
      );
}
