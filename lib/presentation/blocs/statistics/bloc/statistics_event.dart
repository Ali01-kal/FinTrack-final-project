abstract class StatisticsEvent {}

class LoadStatistics extends StatisticsEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  LoadStatistics({this.startDate, this.endDate});
}

class LoadStatisticsByPeriod extends StatisticsEvent {
  final String period;
  LoadStatisticsByPeriod(this.period);
}
