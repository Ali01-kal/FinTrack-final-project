import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_transactions_view_event.dart';
import 'category_transactions_view_state.dart';

class CategoryTransactionsViewBloc
    extends Bloc<CategoryTransactionsViewEvent, CategoryTransactionsViewState> {
  CategoryTransactionsViewBloc({required this.categoryId})
      : super(CategoryTransactionsViewState.initial()) {
    on<CategoryTransactionsSyncRequested>(_onSyncRequested);
  }

  final String categoryId;

  void _onSyncRequested(
    CategoryTransactionsSyncRequested event,
    Emitter<CategoryTransactionsViewState> emit,
  ) {
    final filtered = event.transactions.where((e) => e.categoryId == categoryId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    emit(CategoryTransactionsViewState(items: filtered));
  }
}
