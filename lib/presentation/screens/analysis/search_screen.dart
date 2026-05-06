import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/search_view/search_view_bloc.dart';
import 'package:fintrack/presentation/blocs/search_view/search_view_event.dart';
import 'package:fintrack/presentation/blocs/search_view/search_view_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchViewBloc _viewBloc = SearchViewBloc();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final txState = context.read<TransactionBloc>().state;
    if (txState is TransactionLoaded) {
      _viewBloc.add(SearchViewSyncRequested(txState.transactions));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _viewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : const Color(0xFF1B3D3D);
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
    final blockColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final containerBg = isDark ? const Color(0xFF141414) : const Color(0xFFF4FAF6);

    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionLoaded) {
              _viewBloc.add(SearchViewSyncRequested(state.transactions));
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: primaryTextColor), onPressed: () => context.push('/analysis')),
          title: Text('Search', style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: BlocBuilder<SearchViewBloc, SearchViewState>(
          bloc: _viewBloc,
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: containerBg, borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        TextField(
                          controller: _searchController,
                          onChanged: (value) => _viewBloc.add(SearchQueryChanged(value)),
                          style: TextStyle(color: primaryTextColor),
                          decoration: _inputDeco('Title search', isDark, blockColor),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String?>(
                          dropdownColor: blockColor,
                          value: state.selectedCategory,
                          style: TextStyle(color: primaryTextColor),
                          items: [
                            const DropdownMenuItem(value: null, child: Text('All categories')),
                            ...state.categories.map((c) => DropdownMenuItem(value: c, child: Text(c))),
                          ],
                          onChanged: (v) => _viewBloc.add(SearchCategoryChanged(v)),
                          decoration: _inputDeco('Category', isDark, blockColor),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<TransactionType?>(
                          dropdownColor: blockColor,
                          value: state.selectedType,
                          style: TextStyle(color: primaryTextColor),
                          items: const [
                            DropdownMenuItem(value: null, child: Text('Income + Expense')),
                            DropdownMenuItem(value: TransactionType.income, child: Text('Income')),
                            DropdownMenuItem(value: TransactionType.expense, child: Text('Expense')),
                          ],
                          onChanged: (v) => _viewBloc.add(SearchTypeChanged(v)),
                          decoration: _inputDeco('Type', isDark, blockColor),
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          tileColor: blockColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          title: Text(
                            state.selectedDate == null ? 'All dates' : DateFormat('yyyy-MM-dd').format(state.selectedDate!),
                            style: TextStyle(color: primaryTextColor),
                          ),
                          trailing: Icon(Icons.calendar_today_outlined, color: isDark ? Colors.white60 : Colors.black38),
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: state.selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (d != null) {
                              _viewBloc.add(SearchDateChanged(d));
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(side: BorderSide(color: isDark ? Colors.white24 : Colors.black12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            _searchController.clear();
                            _viewBloc.add(SearchClearRequested());
                          },
                          child: Text('Clear filters', style: TextStyle(color: primaryTextColor)),
                        ),
                        const SizedBox(height: 16),
                        Text('Results: ${state.results.length}', style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor)),
                        const SizedBox(height: 10),
                        if (state.results.isEmpty)
                          Text('No results', style: TextStyle(color: secondaryTextColor)),
                        ...state.results.map((tx) => _item(tx, isDark, blockColor)).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDeco(String label, bool isDark, Color blockColor) => InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? Colors.white60 : Colors.black54),
        filled: true,
        fillColor: blockColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      );

  Widget _item(TransactionEntity tx, bool isDark, Color blockColor) {
    final isExpense = tx.type == TransactionType.expense;
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white60 : Colors.black54;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: blockColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.receipt_long, color: Color(0xFF00D19E)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.title, style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600)),
                Text(
                  '${tx.categoryId} • ${DateFormat('yyyy-MM-dd HH:mm').format(tx.date)}',
                  style: TextStyle(color: secondaryTextColor, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            isExpense ? '-\$${tx.amount.toStringAsFixed(2)}' : '\$${tx.amount.toStringAsFixed(2)}',
            style: TextStyle(color: isExpense ? Colors.redAccent : const Color(0xFF00D19E), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
