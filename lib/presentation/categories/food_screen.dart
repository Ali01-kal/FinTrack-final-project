import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

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
        title: const Text('Food', 
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildTopStats(), // CategoriesScreen-дегідей статистика блогы
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
                    padding: const EdgeInsets.all(25),
                    children: [
                      _buildSectionHeader('April'),
                      _buildFoodItem('Dinner', '18:27 - April 30', '-\$26,00'),
                      _buildFoodItem('Delivery Pizza', '15:00 - April 24', '-\$18,35'),
                      _buildFoodItem('Lunch', '12:30 - April 15', '-\$15,40'),
                      _buildFoodItem('Brunch', '9:30 - April 08', '-\$12,13'),
                      const SizedBox(height: 15),
                      _buildSectionHeader('March'),
                      _buildFoodItem('Dinner', '20:50 - March 31', '-\$27,20'),
                      const SizedBox(height: 80), // Батырма үшін орын
                    ],
                  ),
                  // Add Expenses батырмасы
                  Positioned(
                    bottom: 20,
                    child: ElevatedButton(
                      onPressed: () => context.push('/addexpense'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D19E),
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

  // Сәл бұрын қолданған статистика виджетін мұнда да пайдаланамыз
  Widget _buildTopStats() { /* Алдыңғы кодтағы _buildTopStats мазмұны */ return Container(); }

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
      currentIndex: 3, // Categories бөліміне жататындықтан 3-ші индекс белсенді
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