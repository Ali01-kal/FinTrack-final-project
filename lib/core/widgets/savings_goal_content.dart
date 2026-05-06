import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/savings_goal_view/savings_goal_view_bloc.dart';
import 'package:fintrack/presentation/blocs/savings_goal_view/savings_goal_view_event.dart';
import 'package:fintrack/presentation/blocs/savings_goal_view/savings_goal_view_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:fintrack/presentation/screens/categories/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SavingsGoalContent extends StatelessWidget {
  final String title;
  final String categoryId;
  final double goalAmount;
  final IconData icon;

  const SavingsGoalContent({
    super.key,
    required this.title,
    required this.categoryId,
    required this.goalAmount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final txState = context.read<TransactionBloc>().state;
    final initial = txState is TransactionLoaded ? txState.transactions : <TransactionEntity>[];

    return BlocProvider(
      create: (_) => SavingsGoalViewBloc(
        categoryId: categoryId,
        goalAmount: goalAmount,
      )..add(SavingsGoalSyncRequested(initial)),
      child: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoaded) {
            context.read<SavingsGoalViewBloc>().add(SavingsGoalSyncRequested(state.transactions));
          }
        },
        child: BlocBuilder<SavingsGoalViewBloc, SavingsGoalViewState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Goal', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 12)),
                              Text('\$${goalAmount.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 24, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              const Text('Amount Saved', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 12)),
                              Text('\$${state.saved.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xFF00D19E), fontSize: 24, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(color: const Color(0xFF8ECAFE), borderRadius: BorderRadius.circular(30)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CircularProgressIndicator(
                                    value: state.progress,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(icon, color: Colors.white, size: 30),
                                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 10)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: state.progress,
                          minHeight: 12,
                          backgroundColor: const Color(0xFF00D19E),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1B3D3D)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4FAF6),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ListView(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 90),
                          children: state.items.isEmpty
                              ? [const Padding(padding: EdgeInsets.only(top: 24), child: Text('No savings yet'))]
                              : state.items
                                  .map(
                                    (tx) => Container(
                                      margin: const EdgeInsets.symmetric(vertical: 8),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(color: const Color(0xFF42A5F5).withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                                            child: Icon(icon, color: const Color(0xFF42A5F5)),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                Text(DateFormat('HH:mm - MMM d').format(tx.date), style: const TextStyle(color: Colors.black26, fontSize: 11)),
                                              ],
                                            ),
                                          ),
                                          Text('\$${tx.amount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                        Positioned(
                          bottom: 20,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AddTransactionScreen(
                                  categoryName: title,
                                  categoryId: categoryId,
                                  type: TransactionType.expense,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                            child: const Text('Add Savings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
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
}
