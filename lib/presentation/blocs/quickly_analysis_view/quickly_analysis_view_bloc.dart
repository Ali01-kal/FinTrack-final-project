import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'quickly_analysis_view_event.dart';
import 'quickly_analysis_view_state.dart';

class QuicklyAnalysisViewBloc
    extends Bloc<QuicklyAnalysisViewEvent, QuicklyAnalysisViewState> {
  QuicklyAnalysisViewBloc() : super(QuicklyAnalysisViewState.initial()) {
    on<QuicklyAnalysisSyncRequested>(_onSyncRequested);
  }

  void _onSyncRequested(
    QuicklyAnalysisSyncRequested event,
    Emitter<QuicklyAnalysisViewState> emit,
  ) {
    final now = DateTime.now();
    final weekStart = now.subtract(const Duration(days: 7));
    final weekly = event.transactions
        .where((e) => !e.date.isBefore(weekStart) && !e.date.isAfter(now))
        .toList();
    final income = weekly
        .where((e) => e.type == TransactionType.income)
        .fold<double>(0, (p, e) => p + e.amount);
    final expense = weekly
        .where((e) => e.type == TransactionType.expense)
        .fold<double>(0, (p, e) => p + e.amount);
    final ratio = income <= 0 ? 0.0 : (expense / income).clamp(0.0, 1.0);
    final recent = <TransactionEntity>[...weekly]
      ..sort((a, b) => b.date.compareTo(a.date));

    emit(
      QuicklyAnalysisViewState(
        income: income,
        expense: expense,
        ratio: ratio,
        recent: recent,
      ),
    );
  }
}
