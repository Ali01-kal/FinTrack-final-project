import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_view_event.dart';
import 'search_view_state.dart';

class SearchViewBloc extends Bloc<SearchViewEvent, SearchViewState> {
  SearchViewBloc() : super(SearchViewState.initial()) {
    on<SearchViewSyncRequested>(_onSyncRequested);
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchCategoryChanged>(_onCategoryChanged);
    on<SearchTypeChanged>(_onTypeChanged);
    on<SearchDateChanged>(_onDateChanged);
    on<SearchClearRequested>(_onClearRequested);
  }

  List<TransactionEntity> _all = <TransactionEntity>[];

  void _onSyncRequested(
    SearchViewSyncRequested event,
    Emitter<SearchViewState> emit,
  ) {
    _all = event.transactions;
    emit(_buildState(state));
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchViewState> emit) {
    emit(
      _buildState(
        SearchViewState(
          query: event.query,
          selectedCategory: state.selectedCategory,
          selectedDate: state.selectedDate,
          selectedType: state.selectedType,
          categories: state.categories,
          results: state.results,
        ),
      ),
    );
  }

  void _onCategoryChanged(
    SearchCategoryChanged event,
    Emitter<SearchViewState> emit,
  ) {
    emit(
      _buildState(
        SearchViewState(
          query: state.query,
          selectedCategory: event.category,
          selectedDate: state.selectedDate,
          selectedType: state.selectedType,
          categories: state.categories,
          results: state.results,
        ),
      ),
    );
  }

  void _onTypeChanged(SearchTypeChanged event, Emitter<SearchViewState> emit) {
    emit(
      _buildState(
        SearchViewState(
          query: state.query,
          selectedCategory: state.selectedCategory,
          selectedDate: state.selectedDate,
          selectedType: event.type,
          categories: state.categories,
          results: state.results,
        ),
      ),
    );
  }

  void _onDateChanged(SearchDateChanged event, Emitter<SearchViewState> emit) {
    emit(
      _buildState(
        SearchViewState(
          query: state.query,
          selectedCategory: state.selectedCategory,
          selectedDate: event.date,
          selectedType: state.selectedType,
          categories: state.categories,
          results: state.results,
        ),
      ),
    );
  }

  void _onClearRequested(
    SearchClearRequested event,
    Emitter<SearchViewState> emit,
  ) {
    emit(_buildState(SearchViewState.initial()));
  }

  SearchViewState _buildState(SearchViewState base) {
    final categories = _all.map((e) => e.categoryId).toSet().toList()..sort();
    final results = _all.where((tx) => _match(tx, base)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return SearchViewState(
      query: base.query,
      selectedCategory: base.selectedCategory,
      selectedDate: base.selectedDate,
      selectedType: base.selectedType,
      categories: categories,
      results: results,
    );
  }

  bool _match(TransactionEntity tx, SearchViewState s) {
    if (s.selectedCategory != null && tx.categoryId != s.selectedCategory) {
      return false;
    }
    if (s.selectedType != null && tx.type != s.selectedType) return false;
    if (s.selectedDate != null) {
      final d = s.selectedDate!;
      if (!(tx.date.year == d.year && tx.date.month == d.month && tx.date.day == d.day)) {
        return false;
      }
    }
    final q = s.query.trim().toLowerCase();
    if (q.isNotEmpty && !tx.title.toLowerCase().contains(q)) return false;
    return true;
  }
}
