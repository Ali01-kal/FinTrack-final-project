import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/category_transactions_view/category_transactions_view_bloc.dart';
import 'package:fintrack/presentation/blocs/category_transactions_view/category_transactions_view_event.dart';
import 'package:fintrack/presentation/blocs/category_transactions_view/category_transactions_view_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CategoryTransactionsList extends StatelessWidget {
  final String categoryId;
  final IconData icon;

  const CategoryTransactionsList({
    super.key,
    required this.categoryId,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txState = context.read<TransactionBloc>().state;
    final initial = txState is TransactionLoaded ? txState.transactions : <TransactionEntity>[];

    return BlocProvider(
      create: (_) => CategoryTransactionsViewBloc(categoryId: categoryId)
        ..add(CategoryTransactionsSyncRequested(initial)),
      child: BlocListener<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoaded) {
            context.read<CategoryTransactionsViewBloc>().add(
                  CategoryTransactionsSyncRequested(state.transactions),
                );
          }
        },
        child: BlocBuilder<CategoryTransactionsViewBloc, CategoryTransactionsViewState>(
          builder: (context, state) {
            if (state.items.isEmpty) {
              return const Center(child: Text('No transactions in this category'));
            }

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 90),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final tx = state.items[index];
                final isExpense = tx.type == TransactionType.expense;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: isDark ? const Color(0xFF1A1A1A) : Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF42A5F5).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(icon, color: const Color(0xFF42A5F5)),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              DateFormat('HH:mm - MMM d').format(tx.date),
                              style: TextStyle(color: isDark ? Colors.white60 : Colors.black26, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        isExpense ? '-\$${tx.amount.toStringAsFixed(2)}' : '\$${tx.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isExpense ? const Color(0xFF42A5F5) : const Color(0xFF1B3D3D),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
