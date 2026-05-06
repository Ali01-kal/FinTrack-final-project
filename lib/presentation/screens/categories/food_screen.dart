import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fintrack/domain/entities/transaction_entity.dart';
import 'package:fintrack/presentation/screens/categories/add_transaction_screen.dart';
import 'package:fintrack/core/widgets/finance_top_stats.dart';
import 'package:fintrack/core/widgets/category_transactions_list.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1B3D3D)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
             } else {
              context.go('/categories'); // fallback route
            }
         }
        ),
        title: Text('Food', style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          _buildTopStats(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const CategoryTransactionsList(categoryId: 'food', icon: Icons.restaurant),
                  
                  Positioned(
                    bottom: 20,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AddTransactionScreen(
                            categoryName: 'Food',
                            categoryId: 'food',
                            type: TransactionType.expense,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Add Expenses', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  
  Widget _buildTopStats() => const FinanceTopStats();

  Widget _buildSectionHeader(String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(month, style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold)),
          const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF00D19E)),
        ],
      ),
    );
  }

  Widget _buildFoodItem(String title, String time, String amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.restaurant, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.black26, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
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
      },
    );
  }
}








