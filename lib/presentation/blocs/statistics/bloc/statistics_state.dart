abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final Map<String, double> categoryTotals;
  final double totalExpense;
  final double totalIncome;
  final double totalBalance;
  final double ratio;
  final String ratioPercent;
  final String selectedPeriod;
  final List<String> chartLabels;
  final List<double> chartBars;

  StatisticsLoaded({
    required this.categoryTotals,
    required this.totalExpense,
    required this.totalIncome,
    required this.totalBalance,
    required this.ratio,
    required this.ratioPercent,
    required this.selectedPeriod,
    required this.chartLabels,
    required this.chartBars,
  });
}

class StatisticsError extends StatisticsState {
  final String message;
  StatisticsError(this.message);
}
