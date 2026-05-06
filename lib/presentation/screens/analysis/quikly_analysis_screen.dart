import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/quickly_analysis_view/quickly_analysis_view_bloc.dart';
import 'package:fintrack/presentation/blocs/quickly_analysis_view/quickly_analysis_view_event.dart';
import 'package:fintrack/presentation/blocs/quickly_analysis_view/quickly_analysis_view_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class QuiklyAnalysisScreen extends StatefulWidget {
  const QuiklyAnalysisScreen({super.key});

  @override
  State<QuiklyAnalysisScreen> createState() => _QuiklyAnalysisScreenState();
}

class _QuiklyAnalysisScreenState extends State<QuiklyAnalysisScreen> {
  final QuicklyAnalysisViewBloc _viewBloc = QuicklyAnalysisViewBloc();

  @override
  void initState() {
    super.initState();
    final txState = context.read<TransactionBloc>().state;
    if (txState is TransactionLoaded) {
      _viewBloc.add(QuicklyAnalysisSyncRequested(txState.transactions));
    }
  }

  @override
  void dispose() {
    _viewBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionLoaded) {
              _viewBloc.add(QuicklyAnalysisSyncRequested(state.transactions));
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)), onPressed: () => context.pop()),
          title: const Text('Quickly Analysis', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        ),
        body: BlocBuilder<QuicklyAnalysisViewBloc, QuicklyAnalysisViewState>(
          bloc: _viewBloc,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(value: state.ratio, strokeWidth: 8),
                            Center(child: Text('${(state.ratio * 100).toStringAsFixed(0)}%')),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Income: \$${state.income.toStringAsFixed(2)}\nExpense: \$${state.expense.toStringAsFixed(2)}')),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6), borderRadius: const BorderRadius.vertical(top: Radius.circular(40))),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        const Text('Last 7 days', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        ...state.recent.take(10).map((tx) => ListTile(
                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              title: Text(tx.title),
                              subtitle: Text('${tx.categoryId} • ${DateFormat('yyyy-MM-dd HH:mm').format(tx.date)}'),
                              trailing: Text(
                                tx.type == TransactionType.expense ? '-\$${tx.amount.toStringAsFixed(2)}' : '\$${tx.amount.toStringAsFixed(2)}',
                              ),
                            )),
                        if (state.recent.isEmpty) const Padding(padding: EdgeInsets.only(top: 20), child: Text('No weekly data')),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
