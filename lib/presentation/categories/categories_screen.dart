import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Негізгі жасыл түс
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text('Categories', 
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
          // 1. Жоғарғы статистикалық ақпарат (Balance & Expense)
          _buildTopStats(),
          
          const SizedBox(height: 30),

          // 2. Категориялар торы (White Container)
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(25, 40, 25, 0),
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 25,
                children: [
                  _buildCategoryItem(context, 'Food', Icons.restaurant, Colors.blue,'/food'),
                  _buildCategoryItem(context,'Transport', Icons.directions_bus, Colors.blue,'/transport'),
                  _buildCategoryItem(context,'Medicine', Icons.medical_services_outlined, Colors.blue,'/medicine'),
                  _buildCategoryItem(context,'Groceries', Icons.shopping_basket_outlined, Colors.blue,'/groceries'),
                  _buildCategoryItem(context,'Rent', Icons.vpn_key_outlined, Colors.blue,'/rent'),
                  _buildCategoryItem(context,'Gifts', Icons.card_giftcard, Colors.blue,'/gifts'),
                  _buildCategoryItem(context,'Savings', Icons.savings_outlined, Colors.blue,'/saving'),
                  _buildCategoryItem(context,'Entertainment', Icons.confirmation_number_outlined, Colors.blue,'/entertainment'),
                  _buildCategoryItem(context,'More', Icons.add, Colors.blue,'/food'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

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
          // Прогресс бар
          Stack(
            children: [
              Container(
                height: 12,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                height: 12,
                width: 100, // 30% шамасында
                decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('30%', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 12, fontWeight: FontWeight.bold)),
              Text('\$20,000.00', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('✓ 30% Of Your Expenses, Looks Good.', 
              style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 11)),
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
          fontSize: 20, 
          fontWeight: FontWeight.bold
        )),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, String label, IconData icon, Color color, String route) {
  return GestureDetector(
    onTap: () => context.push(route), // Маршрутқа өту
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
            ]
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1B3D3D))),
      ],
    ),
  );
}

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 3, // Categories белсенді
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
      },
    );
  }
}