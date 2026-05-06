import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class QuicklyAnalysisViewEvent {}

class QuicklyAnalysisSyncRequested extends QuicklyAnalysisViewEvent {
  QuicklyAnalysisSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}
