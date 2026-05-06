import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/blocs/categories_view/categories_view_bloc.dart';
import 'package:fintrack/presentation/blocs/categories_view/categories_view_event.dart';
import 'package:fintrack/presentation/blocs/categories_view/categories_view_state.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesViewBloc _viewBloc = CategoriesViewBloc();

  @override
  void initState() {
    super.initState();
    final txState = context.read<TransactionBloc>().state;
    if (txState is TransactionLoaded) {
      _viewBloc.add(CategoriesViewSyncRequested(txState.transactions));
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
              _viewBloc.add(CategoriesViewSyncRequested(state.transactions));
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Categories',
            style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            _buildTopStats(context),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 25,
                  children: [
                    _buildCategoryItem(context, 'Food', Icons.restaurant, Colors.blue, '/food'),
                    _buildCategoryItem(context, 'Transport', Icons.directions_bus, Colors.blue, '/transport'),
                    _buildCategoryItem(context, 'Medicine', Icons.medical_services_outlined, Colors.blue, '/medicine'),
                    _buildCategoryItem(context, 'Groceries', Icons.shopping_basket_outlined, Colors.blue, '/groceries'),
                    _buildCategoryItem(context, 'Rent', Icons.vpn_key_outlined, Colors.blue, '/rent'),
                    _buildCategoryItem(context, 'Gifts', Icons.card_giftcard, Colors.blue, '/gifts'),
                    _buildCategoryItem(context, 'Savings', Icons.savings_outlined, Colors.blue, '/saving'),
                    _buildCategoryItem(context, 'Entertainment', Icons.confirmation_number_outlined, Colors.blue, '/entertainment'),
                    _buildCategoryItem(context, 'Income', Icons.arrow_outward, Colors.blue, '/income'),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildTopStats(BuildContext context) {
    return BlocBuilder<CategoriesViewBloc, CategoriesViewState>(
      bloc: _viewBloc,
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${(state.progress * 100).toStringAsFixed(0)}%', style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF1B3D3D), fontSize: 12, fontWeight: FontWeight.bold)),
                  Text('\$${state.income.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF1B3D3D), fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Expense ratio: ${(state.progress * 100).toStringAsFixed(0)}% of income.',
                  style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : const Color(0xFF1B3D3D), fontSize: 11),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatDetail(BuildContext context, String title, String amount, {bool isExpense = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF1B3D3D), fontSize: 12)),
        Text(amount, style: TextStyle(color: isExpense ? const Color(0xFF2196F3) : Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, String label, IconData icon, Color color, String route) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => context.push(route),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isDark ? Colors.white : const Color(0xFF1B3D3D))),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      selectedItemColor: const Color(0xFF00D19E),
      unselectedItemColor: Colors.black26,
      showSelectedLabels: false,
      showUnselectedLabels: false,
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
        if (index == 2) context.go('/transaction');
        if (index == 3) context.go('/categories');
        if (index == 4) context.go('/profile');
      },
    );
  }
}
