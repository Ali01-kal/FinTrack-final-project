import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/calendar_view/calendar_view_bloc.dart';
import 'package:fintrack/presentation/blocs/calendar_view/calendar_view_event.dart';
import 'package:fintrack/presentation/blocs/calendar_view/calendar_view_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarViewBloc _viewBloc = CalendarViewBloc();

  @override
  void initState() {
    super.initState();
    final txState = context.read<TransactionBloc>().state;
    if (txState is TransactionLoaded) {
      _viewBloc.add(CalendarViewSyncRequested(txState.transactions));
    }
  }

  @override
  void dispose() {
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
              _viewBloc.add(CalendarViewSyncRequested(state.transactions));
            }
          },
        ),
      ],
      child: BlocBuilder<CalendarViewBloc, CalendarViewState>(
        bloc: _viewBloc,
        builder: (context, viewState) {
          return Scaffold(
            backgroundColor: Colors.amber,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1B3D3D)),
                onPressed: () => context.push('/analysis'),
              ),
              title: Text('Calendar', style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: containerBg, borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        ListTile(
                          tileColor: blockColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          title: Text(
                            'Selected: ${DateFormat('yyyy-MM-dd').format(viewState.selectedDay)}',
                            style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w500),
                          ),
                          trailing: Icon(Icons.calendar_today, color: isDark ? Colors.white60 : Colors.black38),
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: viewState.selectedDay,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (d != null) {
                              _viewBloc.add(CalendarDayChanged(d));
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        _switcher(isDark, blockColor, viewState.isSpendsSelected),
                        const SizedBox(height: 14),
                        if (viewState.isSpendsSelected)
                          ...viewState.dayTransactions.map((e) => _spendItem(e, isDark, blockColor)).toList()
                        else
                          ...viewState.byCategory.entries.map((e) {
                            final ratio = viewState.totalExpense == 0 ? 0.0 : e.value / viewState.totalExpense;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(color: blockColor, borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                title: Text(e.key, style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600)),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: LinearProgressIndicator(
                                    value: ratio,
                                    backgroundColor: isDark ? Colors.white10 : Colors.black12,
                                    color: const Color(0xFF00D19E),
                                  ),
                                ),
                                trailing: Text(
                                  '\$${e.value.toStringAsFixed(2)}',
                                  style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList(),
                        if (viewState.dayTransactions.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text('No data for this day', style: TextStyle(color: secondaryTextColor)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _switcher(bool isDark, Color blockColor, bool isSpendsSelected) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: blockColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _tab('Spends', isSpendsSelected, isDark, () => _viewBloc.add(CalendarTabChanged(true))),
          _tab('Categories', !isSpendsSelected, isDark, () => _viewBloc.add(CalendarTabChanged(false))),
        ],
      ),
    );
  }

  Widget _tab(String t, bool sel, bool isDark, VoidCallback onTap) => Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: sel ? Colors.amber : Colors.transparent, borderRadius: BorderRadius.circular(10)),
            child: Text(t, style: TextStyle(color: sel ? Colors.white : (isDark ? Colors.white54 : Colors.black54), fontWeight: FontWeight.bold)),
          ),
        ),
      );

  Widget _spendItem(TransactionEntity tx, bool isDark, Color blockColor) {
    final isExpense = tx.type == TransactionType.expense;
    final primaryTextColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white60 : Colors.black54;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: blockColor, borderRadius: BorderRadius.circular(12)),
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
                  '${tx.categoryId} • ${DateFormat('HH:mm').format(tx.date)}',
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
