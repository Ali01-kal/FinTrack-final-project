import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/finance_top_stats/finance_top_stats_bloc.dart';
import 'package:fintrack/presentation/blocs/finance_top_stats/finance_top_stats_event.dart';
import 'package:fintrack/presentation/blocs/finance_top_stats/finance_top_stats_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceTopStats extends StatelessWidget {
  const FinanceTopStats({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txState = context.read<TransactionBloc>().state;
    final initial = txState is TransactionLoaded ? txState.transactions : <TransactionEntity>[];

    return BlocProvider(
      create: (_) => FinanceTopStatsBloc()..add(FinanceTopStatsSyncRequested(initial)),
      child: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoaded) {
            context.read<FinanceTopStatsBloc>().add(FinanceTopStatsSyncRequested(state.transactions));
          }
        },
        child: BlocBuilder<FinanceTopStatsBloc, FinanceTopStatsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatDetail(context, 'Total Balance', '\$${state.balance.toStringAsFixed(2)}'),
                      Container(width: 1, height: 40, color: Colors.white30),
                      _buildStatDetail(context, 'Total Expense', '-\$${state.expense.toStringAsFixed(2)}', isExpense: true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      ),
                      FractionallySizedBox(
                        widthFactor: state.progress,
                        child: Container(
                          height: 12,
                          decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatDetail(BuildContext context, String title, String amount, {bool isExpense = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF1B3D3D), fontSize: 12)),
        Text(
          amount,
          style: TextStyle(
            color: isExpense ? const Color(0xFF2196F3) : (isDark ? Colors.white : Colors.white),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
