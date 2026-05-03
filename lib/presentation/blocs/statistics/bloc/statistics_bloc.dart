import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/domain/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final TransactionRepository repository;

  StatisticsBloc({required this.repository}) : super(StatisticsInitial()) {
    on<LoadStatistics>((event, emit) async {
      emit(StatisticsLoading());
      try {
        final transactions = await repository.getAllTransactions();
        
        // 1. Уақыт бойынша сүзу (егер даталар берілсе)
        final filteredTransactions = transactions.where((tx) {
          if (event.startDate != null && tx.date.isBefore(event.startDate!)) return false;
          if (event.endDate != null && tx.date.isAfter(event.endDate!)) return false;
          return true;
        }).toList();

        // 2. Жиынтық сомаларды есептеу
        double totalIncome = 0;
        double totalExpense = 0;
        Map<String, double> categoryTotals = {};

        for (var tx in filteredTransactions) {
          if (tx.type == TransactionType.income) {
            totalIncome += tx.amount;
          } else {
            totalExpense += tx.amount;
            // Шығыстарды санат бойынша топтау
            categoryTotals[tx.categoryId] = (categoryTotals[tx.categoryId] ?? 0) + tx.amount;
          }
        }

        emit(StatisticsLoaded(
          categoryTotals: categoryTotals,
          totalExpense: totalExpense,
          totalIncome: totalIncome,
        ));
      } catch (e) {
        emit(StatisticsError("Статистиканы жүктеу мүмкін болмады: $e"));
      }
    });
  }
}