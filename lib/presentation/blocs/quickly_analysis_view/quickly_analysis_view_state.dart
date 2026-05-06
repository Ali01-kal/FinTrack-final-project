import 'package:fintrack/domain/entities/transaction_entity.dart';

class QuicklyAnalysisViewState {
  const QuicklyAnalysisViewState({
    required this.income,
    required this.expense,
    required this.ratio,
    required this.recent,
  });

  final double income;
  final double expense;
  final double ratio;
  final List<TransactionEntity> recent;

  factory QuicklyAnalysisViewState.initial() => const QuicklyAnalysisViewState(
        income: 0,
        expense: 0,
        ratio: 0,
        recent: <TransactionEntity>[],
      );
}
