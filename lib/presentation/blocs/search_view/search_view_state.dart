import 'package:fintrack/domain/entities/transaction_entity.dart';

class SearchViewState {
  const SearchViewState({
    required this.query,
    required this.selectedCategory,
    required this.selectedDate,
    required this.selectedType,
    required this.categories,
    required this.results,
  });

  final String query;
  final String? selectedCategory;
  final DateTime? selectedDate;
  final TransactionType? selectedType;
  final List<String> categories;
  final List<TransactionEntity> results;

  factory SearchViewState.initial() => const SearchViewState(
        query: '',
        selectedCategory: null,
        selectedDate: null,
        selectedType: null,
        categories: <String>[],
        results: <TransactionEntity>[],
      );
}
