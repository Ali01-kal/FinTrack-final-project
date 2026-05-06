import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'categories_view_event.dart';
import 'categories_view_state.dart';

class CategoriesViewBloc extends Bloc<CategoriesViewEvent, CategoriesViewState> {
  CategoriesViewBloc() : super(CategoriesViewState.initial()) {
    on<CategoriesViewSyncRequested>(_onSyncRequested);
  }

  void _onSyncRequested(
    CategoriesViewSyncRequested event,
    Emitter<CategoriesViewState> emit,
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
      CategoriesViewState(
        income: income,
        expense: expense,
        balance: balance,
        progress: progress,
      ),
    );
  }
}
