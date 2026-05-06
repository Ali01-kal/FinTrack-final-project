import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final TransactionRepository repository;

  StatisticsBloc({required this.repository}) : super(StatisticsInitial()) {
    on<LoadStatistics>((event, emit) async {
      await _load(
        emit: emit,
        startDate: event.startDate,
        endDate: event.endDate,
        period: 'Custom',
      );
    });

    on<LoadStatisticsByPeriod>((event, emit) async {
      final range = _resolveRange(event.period);
      await _load(
        emit: emit,
        startDate: range.$1,
        endDate: range.$2,
        period: event.period,
      );
    });
  }

  Future<void> _load({
    required Emitter<StatisticsState> emit,
    required DateTime? startDate,
    required DateTime? endDate,
    required String period,
  }) async {
    emit(StatisticsLoading());
    try {
      final transactions = await repository.getAllTransactions();
      final filteredTransactions = transactions.where((tx) {
        if (startDate != null && tx.date.isBefore(startDate)) return false;
        if (endDate != null && tx.date.isAfter(endDate)) return false;
        return true;
      }).toList();

      double totalIncome = 0;
      double totalExpense = 0;
      final categoryTotals = <String, double>{};
      for (final tx in filteredTransactions) {
        if (tx.type == TransactionType.income) {
          totalIncome += tx.amount;
        } else {
          totalExpense += tx.amount;
          categoryTotals[tx.categoryId] = (categoryTotals[tx.categoryId] ?? 0) + tx.amount;
        }
      }

      final totalBalance = totalIncome - totalExpense;
      final ratio = totalIncome <= 0 ? 0.0 : (totalExpense / totalIncome).clamp(0.0, 1.0);
      final chartData = _buildChartData(categoryTotals);

      emit(
        StatisticsLoaded(
          categoryTotals: categoryTotals,
          totalExpense: totalExpense,
          totalIncome: totalIncome,
          totalBalance: totalBalance,
          ratio: ratio,
          ratioPercent: (ratio * 100).toStringAsFixed(0),
          selectedPeriod: period,
          chartLabels: chartData.$1,
          chartBars: chartData.$2,
        ),
      );
    } catch (e) {
      emit(StatisticsError("Статистиканы жүктеу мүмкін болмады: $e"));
    }
  }

  (DateTime?, DateTime?) _resolveRange(String period) {
    final now = DateTime.now();
    switch (period) {
      case 'Daily':
        return (DateTime(now.year, now.month, now.day), now);
      case 'Weekly':
        return (DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6)), now);
      case 'Monthly':
        return (DateTime(now.year, now.month, 1), now);
      case 'Year':
        return (DateTime(now.year, 1, 1), now);
      default:
        return (null, now);
    }
  }

  (List<String>, List<double>) _buildChartData(Map<String, double> categoryTotals) {
    if (categoryTotals.isEmpty) return (const <String>['No data'], const <double>[0.0]);
    final entries = categoryTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topEntries = entries.take(6).toList();
    final maxValue = topEntries.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return (
      topEntries.map((e) => e.key).toList(),
      topEntries.map((e) => maxValue == 0 ? 0.0 : (e.value / maxValue) * 100).toList(),
    );
  }
}
