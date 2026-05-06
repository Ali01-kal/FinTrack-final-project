import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'savings_goal_view_event.dart';
import 'savings_goal_view_state.dart';

class SavingsGoalViewBloc extends Bloc<SavingsGoalViewEvent, SavingsGoalViewState> {
  SavingsGoalViewBloc({
    required this.categoryId,
    required this.goalAmount,
  }) : super(SavingsGoalViewState.initial()) {
    on<SavingsGoalSyncRequested>(_onSyncRequested);
  }

  final String categoryId;
  final double goalAmount;

  void _onSyncRequested(
    SavingsGoalSyncRequested event,
    Emitter<SavingsGoalViewState> emit,
  ) {
    final items = event.transactions
        .where((e) => e.categoryId == categoryId && e.type == TransactionType.expense)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final saved = items.fold<double>(0, (p, e) => p + e.amount);
    final progress = goalAmount <= 0 ? 0.0 : (saved / goalAmount).clamp(0.0, 1.0);
    emit(
      SavingsGoalViewState(
        items: items,
        saved: saved,
        progress: progress,
      ),
    );
  }
}
