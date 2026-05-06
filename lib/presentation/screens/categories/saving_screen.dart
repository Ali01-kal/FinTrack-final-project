import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fintrack/core/widgets/finance_top_stats.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)), 
          onPressed: () {
            if (context.canPop()) {
              context.pop();
             } else {
              context.go('/categories'); // fallback route
            }
         }
        ),
        title: const Text('Savings', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const FinanceTopStats(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75,
                      padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                      children: [
                        _buildSavingGoal(context, 'Travel', Icons.airplanemode_active, Colors.blue, '/detailTravel'),
                        _buildSavingGoal(context, 'New House', Icons.house_outlined, Colors.blue, '/newHouse'),
                        _buildSavingGoal(context, 'Car', Icons.directions_car_filled_outlined, Colors.blue, '/carDetail'),
                        _buildSavingGoal(context, 'Wedding', Icons.brightness_high_outlined, Colors.blue, '/weddingDetail'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () => context.push('/addSavings'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      ),
                      child: const Text('Add More', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  Widget _buildSavingGoal(BuildContext context, String label, IconData icon, Color color, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
            child: Icon(icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
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


