import 'package:fintrack/domain/entities/transaction_entity.dart';

class CalendarViewState {
  const CalendarViewState({
    required this.selectedDay,
    required this.isSpendsSelected,
    required this.dayTransactions,
    required this.byCategory,
    required this.totalExpense,
  });

  final DateTime selectedDay;
  final bool isSpendsSelected;
  final List<TransactionEntity> dayTransactions;
  final Map<String, double> byCategory;
  final double totalExpense;

  factory CalendarViewState.initial() => CalendarViewState(
        selectedDay: DateTime.now(),
        isSpendsSelected: true,
        dayTransactions: const <TransactionEntity>[],
        byCategory: const <String, double>{},
        totalExpense: 0,
      );
}
