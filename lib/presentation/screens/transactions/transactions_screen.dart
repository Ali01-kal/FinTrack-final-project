import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_event.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:fintrack/presentation/blocs/transactions_view/transactions_view_bloc.dart';
import 'package:fintrack/presentation/blocs/transactions_view/transactions_view_event.dart';
import 'package:fintrack/presentation/blocs/transactions_view/transactions_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionsViewBloc _viewBloc = TransactionsViewBloc();

  @override
  void initState() {
    super.initState();
    final txState = context.read<TransactionBloc>().state;
    if (txState is TransactionLoaded) {
      _viewBloc.add(TransactionsViewSyncRequested(txState.transactions));
    } else {
      context.read<TransactionBloc>().add(LoadTransactions());
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
    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionLoaded) {
              _viewBloc.add(TransactionsViewSyncRequested(state.transactions));
            }
          },
        ),
      ],
      child: BlocBuilder<TransactionsViewBloc, TransactionsViewState>(
        bloc: _viewBloc,
        builder: (context, viewState) {
          return Scaffold(
            backgroundColor: Colors.amber,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Transaction',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF1B3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                _buildBalanceCard(context, viewState.balance),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      _buildFilterButton(
                        context,
                        'Income',
                        viewState.incomeTotal,
                        Icons.arrow_outward,
                        1,
                        viewState.activeFilter,
                      ),
                      const SizedBox(width: 15),
                      _buildFilterButton(
                        context,
                        'Expense',
                        viewState.expenseTotal,
                        Icons.call_received,
                        2,
                        viewState.activeFilter,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF141414)
                          : const Color(0xFFF4FAF6),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: viewState.filtered.isEmpty
                        ? const Center(child: Text('No transactions yet'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(25),
                            itemCount: viewState.filtered.length,
                            itemBuilder: (context, index) {
                              final tx = viewState.filtered[index];
                              return _buildItem(context, tx);
                            },
                          ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _buildBottomNav(),
          );
        },
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, double balance) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text('Total Balance', style: TextStyle(color: isDark ? Colors.white60 : Colors.black45, fontSize: 14)),
          const SizedBox(height: 5),
          Text(_money(balance), style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1B3D3D))),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String title,
    double amount,
    IconData icon,
    int filterIndex,
    int activeFilter,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = activeFilter == filterIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _viewBloc.add(TransactionsFilterChanged(filterIndex)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(color: isSelected ? const Color(0xFF2196F3) : (isDark ? const Color(0xFF1A1A1A) : Colors.white), borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.white : const Color(0xFF00D19E), size: 20),
              const SizedBox(height: 5),
              Text(title, style: TextStyle(color: isSelected ? Colors.white70 : (isDark ? Colors.white70 : Colors.black45), fontSize: 12)),
              Text(_money(amount), style: TextStyle(color: isSelected ? Colors.white : (isDark ? Colors.white : const Color(0xFF1B3D3D)), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, TransactionEntity tx) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpense = tx.type == TransactionType.expense;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1A1A1A) : Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: Icon(isExpense ? Icons.call_received : Icons.arrow_outward, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.title, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
                Text(DateFormat('HH:mm - MMM d').format(tx.date), style: TextStyle(color: isDark ? Colors.white60 : Colors.black26, fontSize: 11)),
              ],
            ),
          ),
          Text(
            isExpense ? '-${_money(tx.amount)}' : _money(tx.amount),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: isDark ? Colors.white54 : Colors.black38),
            onSelected: (value) {
              if (value == 'edit') {
                _showEditDialog(context, tx);
              } else if (value == 'delete') {
                context.read<TransactionBloc>().add(DeleteTransaction(tx.id));
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  String _money(double amount) => '\$${amount.toStringAsFixed(2)}';

  Future<void> _showEditDialog(BuildContext context, TransactionEntity tx) async {
    final titleController = TextEditingController(text: tx.title);
    final amountController = TextEditingController(text: tx.amount.toStringAsFixed(2));

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text.trim().replaceAll(',', '.'));
                if (amount == null || titleController.text.trim().isEmpty) return;
                final updated = TransactionEntity(
                  id: tx.id,
                  title: titleController.text.trim(),
                  amount: amount,
                  date: tx.date,
                  categoryId: tx.categoryId,
                  type: tx.type,
                  note: tx.note,
                );
                context.read<TransactionBloc>().add(UpdateTransaction(updated));
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 2,
      selectedItemColor: const Color(0xFF00D19E),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
      onTap: (index) {
        if (index == 0) context.go('/home');
        if (index == 1) context.go('/analysis');
        if (index == 3) context.go('/categories');
        if (index == 4) context.go('/profile');
      },
    );
  }
}
