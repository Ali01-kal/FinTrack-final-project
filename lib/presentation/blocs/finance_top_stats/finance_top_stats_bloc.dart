import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'finance_top_stats_event.dart';
import 'finance_top_stats_state.dart';

class FinanceTopStatsBloc
    extends Bloc<FinanceTopStatsEvent, FinanceTopStatsState> {
  FinanceTopStatsBloc() : super(FinanceTopStatsState.initial()) {
    on<FinanceTopStatsSyncRequested>(_onSyncRequested);
  }

  void _onSyncRequested(
    FinanceTopStatsSyncRequested event,
    Emitter<FinanceTopStatsState> emit,
  ) {
    final income = event.transactions
        .where((e) => e.type == TransactionType.income)
        .fold<double>(0, (p, e) => p + e.amount);
    final expense = event.transactions
        .where((e) => e.type == TransactionType.expense)
        .fold<double>(0, (p, e) => p + e.amount);
    final balance = income - expense;
    final progress = income <= 0 ? 0.0 : (expense / income).clamp(0.0, 1.0);
    emit(
      FinanceTopStatsState(
        income: income,
        expense: expense,
        balance: balance,
        progress: progress,
      ),
    );
  }
}
