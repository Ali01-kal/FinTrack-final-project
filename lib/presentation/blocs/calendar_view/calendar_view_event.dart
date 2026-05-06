import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class CalendarViewEvent {}

class CalendarViewSyncRequested extends CalendarViewEvent {
  CalendarViewSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}

class CalendarDayChanged extends CalendarViewEvent {
  CalendarDayChanged(this.day);
  final DateTime day;
}

class CalendarTabChanged extends CalendarViewEvent {
  CalendarTabChanged(this.isSpendsSelected);
  final bool isSpendsSelected;
}
