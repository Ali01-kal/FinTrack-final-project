import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

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
        title: const Text('Transport', 
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
          // Жоғарғы статистика блогы (FoodScreen-дегідей)
          _buildTopStats(),
          
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
                      _buildSectionHeader('March'),
                      _buildTransportItem('Fuel', '18:27 - March 30', '-\$3,53'),
                      _buildTransportItem('Car Parts', '15:00 - March 30', '-\$26,75'),
                      
                      const SizedBox(height: 20),
                      
                      _buildSectionHeader('February'),
                      _buildTransportItem('New Tires', '12:47 - February 10', '-\$373,99'),
                      _buildTransportItem('Car Wash', '9:30 - February 09', '-\$9,74'),
                      _buildTransportItem('Public Transport', '7:50 - February 01', '-\$1,24'),
                      
                      const SizedBox(height: 80), // Батырмаға орын қалдыру
                    ],
                  ),
                  
                  // Add Expenses батырмасы
                  Positioned(
                    bottom: 20,
                    child: ElevatedButton(
                      onPressed: () => context.push('/addexpense'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Add Expenses', 
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

  // Транспорт шығындарының элементі
  Widget _buildTransportItem(String title, String time, String amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Icon(Icons.directions_bus, color: Color(0xFF42A5F5)),
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
          Text(amount, 
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF42A5F5))),
        ],
      ),
    );
  }

  // Секция тақырыбы (Айлар)
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

  // Жоғарғы статистика (Ортақ виджетке шығару ұсынылады)
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
              Container(
                height: 12, width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                height: 12, width: 100,
                decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatDetail(String title, String amount, {bool isExpense = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 12)),
        Text(amount, style: TextStyle(
          color: isExpense ? const Color(0xFF2196F3) : Colors.white, 
          fontSize: 20, fontWeight: FontWeight.bold
        )),
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