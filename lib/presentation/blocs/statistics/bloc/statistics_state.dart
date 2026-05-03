abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  // Санат атауы және оған тиісті сома (Map түрінде)
  final Map<String, double> categoryTotals;
  final double totalExpense;
  final double totalIncome;

  StatisticsLoaded({
    required this.categoryTotals,
    required this.totalExpense,
    required this.totalIncome,
  });
}

class StatisticsError extends StatisticsState {
  final String message;
  StatisticsError(this.message);
}