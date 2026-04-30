import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          onPressed: () => context.pop(),
        ),
        title: const Text('Savings', 
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopStats(),
          const SizedBox(height: 20),
          Expanded(
  child: Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Color(0xFFF4FAF6),
      borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
    ),
    child: Column( // Stack орнына Column қолданған ыңғайлы
      children: [
        Expanded(
          child: GridView.count(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(), // Егер Column ішінде болса
  crossAxisCount: 3,
  crossAxisSpacing: 20,
  mainAxisSpacing: 20,
  childAspectRatio: 0.75, // Бұл маңызды! 1.0-ден кіші болса, элемент тігінен ұзарады
  padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
  children: [
    _buildSavingGoal(context,'Travel', Icons.airplanemode_active, Colors.blue,'/detailTravel'),
    _buildSavingGoal(context,'New House', Icons.house_outlined, Colors.blue,'/newHouse'),
    _buildSavingGoal(context,'Car', Icons.directions_car_filled_outlined, Colors.blue,'/carDetail'),
    _buildSavingGoal(context,'Wedding', Icons.brightness_high_outlined, Colors.blue,'/weddingDetail'),
  ],
)
        ),
        
        // Батырманы төменгі жақта ұстау үшін
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107), // Скриншоттағыдай сары түс
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
            ),
            child: const Text('Add More', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
    onTap: () => context.push(route), // Осы жерде өту орындалады
    child: Column(
      children: [
        Container(
          height: 80, width: 80,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

  // Ортақ статистика және навигация виджеттері
  Widget _buildTopStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatDetail('Total Balance', '\$7,783.00'),
              Container(width: 1, height: 40, color: Colors.white30),
              _buildStatDetail('Total Expense', '-\$1,187.40', isExpense: true),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(height: 12, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10))),
              Container(height: 12, width: 100, decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10))),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.check_box_outlined, size: 14, color: Color(0xFF1B3D3D)),
              SizedBox(width: 5),
              Text('30% Of Your Expenses, Looks Good.', style: TextStyle(fontSize: 11, color: Color(0xFF1B3D3D))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatDetail(String title, String amount, {bool isExpense = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 12)),
        Text(amount, style: TextStyle(color: isExpense ? const Color(0xFF2196F3) : Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
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
        if (index == 0) context.go('/');
        if (index == 1) context.go('/analysis');
        if (index == 2) context.go('/transactions');
        if (index == 3) context.go('/categories');
      },
    );
  }
}