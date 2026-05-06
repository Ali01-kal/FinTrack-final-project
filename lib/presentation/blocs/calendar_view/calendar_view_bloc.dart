import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_view_event.dart';
import 'calendar_view_state.dart';

class CalendarViewBloc extends Bloc<CalendarViewEvent, CalendarViewState> {
  CalendarViewBloc() : super(CalendarViewState.initial()) {
    on<CalendarViewSyncRequested>(_onSyncRequested);
    on<CalendarDayChanged>(_onDayChanged);
    on<CalendarTabChanged>(_onTabChanged);
  }

  List<TransactionEntity> _all = <TransactionEntity>[];

  void _onSyncRequested(
    CalendarViewSyncRequested event,
    Emitter<CalendarViewState> emit,
  ) {
    _all = event.transactions;
    emit(_buildState(day: state.selectedDay, isSpendsSelected: state.isSpendsSelected));
  }

  void _onDayChanged(
    CalendarDayChanged event,
    Emitter<CalendarViewState> emit,
  ) {
    emit(_buildState(day: event.day, isSpendsSelected: state.isSpendsSelected));
  }

  void _onTabChanged(
    CalendarTabChanged event,
    Emitter<CalendarViewState> emit,
  ) {
    emit(_buildState(day: state.selectedDay, isSpendsSelected: event.isSpendsSelected));
  }

  CalendarViewState _buildState({
    required DateTime day,
    required bool isSpendsSelected,
  }) {
    final dayTransactions = _all.where((e) => _sameDay(e.date, day)).toList();
    final byCategory = <String, double>{};
    for (final tx in dayTransactions.where((e) => e.type == TransactionType.expense)) {
      byCategory[tx.categoryId] = (byCategory[tx.categoryId] ?? 0) + tx.amount;
    }
    final totalExpense = byCategory.values.fold<double>(0, (p, e) => p + e);
    return CalendarViewState(
      selectedDay: day,
      isSpendsSelected: isSpendsSelected,
      dayTransactions: dayTransactions,
      byCategory: byCategory,
      totalExpense: totalExpense,
    );
  }

  bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
