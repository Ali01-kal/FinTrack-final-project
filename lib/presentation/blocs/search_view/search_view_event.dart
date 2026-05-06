import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class SearchViewEvent {}

class SearchViewSyncRequested extends SearchViewEvent {
  SearchViewSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}

class SearchQueryChanged extends SearchViewEvent {
  SearchQueryChanged(this.query);
  final String query;
}

class SearchCategoryChanged extends SearchViewEvent {
  SearchCategoryChanged(this.category);
  final String? category;
}

class SearchTypeChanged extends SearchViewEvent {
  SearchTypeChanged(this.type);
  final TransactionType? type;
}

class SearchDateChanged extends SearchViewEvent {
  SearchDateChanged(this.date);
  final DateTime? date;
}

class SearchClearRequested extends SearchViewEvent {}
