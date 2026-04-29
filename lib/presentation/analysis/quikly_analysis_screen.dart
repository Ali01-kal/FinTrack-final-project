import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuiklyAnalysisScreen extends StatelessWidget {
  const QuiklyAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Негізгі жалбыз түсі
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Quickly Analysis',
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black, size: 20),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Жоғарғы бөлім (Savings және Статистика)
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                // Дөңгелек прогресс (Savings)
                _buildCircularProgress(),
                const SizedBox(width: 20),
                // Кіріс/Шығыс мәтіндері
                const Expanded(
                  child: Column(
                    children: [
                      _SmallStatTile(title: 'Revenue Last Week', amount: '\$4.000.00', icon: Icons.payments, color: Colors.black),
                      Divider(color: Colors.white30),
                      _SmallStatTile(title: 'Food Last Week', amount: '- \$100.00', icon: Icons.restaurant, color: Colors.blueAccent),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Ақ блок (График және Транзакциялар)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // График тақырыбы және иконкалар
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('April Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            _buildCircleIcon(Icons.search),
                            const SizedBox(width: 10),
                            _buildCircleIcon(Icons.calendar_today),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // График бөлімі
                    _buildBarChart(),
                    
                    const SizedBox(height: 30),

                    // Транзакциялар тізімі
                    _buildSimpleTransaction('Salary', 'Monthly', '\$4.000,00', Icons.account_balance_wallet, Colors.blue),
                    _buildSimpleTransaction('Groceries', 'Pantry', '-\$100,00', Icons.shopping_bag, Colors.orange),
                    _buildSimpleTransaction('Rent', 'Rent', '-\$674,40', Icons.vpn_key, Colors.indigo),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Дөңгелек прогресс виджеті
  Widget _buildCircularProgress() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: 0.7,
            strokeWidth: 8,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
          ),
        ),
        const Column(
          children: [
            Icon(Icons.directions_car, color: Color(0xFF1B3D3D)),
            Text('Savings', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            Text('On Goals', style: TextStyle(fontSize: 8)),
          ],
        ),
      ],
    );
  }

  // График (Bar Chart) - Қолдан жасалған нұсқасы
  Widget _buildBarChart() {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBarGroup('1st Week', [30, 50]),
          _buildBarGroup('2nd Week', [40, 70]),
          _buildBarGroup('3rd Week', [60, 90]),
          _buildBarGroup('4th Week', [80, 50]),
        ],
      ),
    );
  }

  Widget _buildBarGroup(String label, List<double> heights) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: 8, height: heights[0], decoration: BoxDecoration(color: const Color(0xFF00D19E), borderRadius: BorderRadius.circular(5))),
            const SizedBox(width: 4),
            Container(width: 8, height: heights[1], decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5))),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.black45)),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Color(0xFF00D19E), shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }

  Widget _buildSimpleTransaction(String title, String cat, String amount, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('18:27 - April 30', style: TextStyle(color: Colors.blue.shade900, fontSize: 10)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF00D19E),
      unselectedItemColor: Colors.black26,
      currentIndex: 1, // Analysis таңдаулы тұр
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}

// Кішігірім ақпараттық плитка
class _SmallStatTile extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;

  const _SmallStatTile({required this.title, required this.amount, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30, color: const Color(0xFF1B3D3D)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.black54)),
            Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ],
    );
  }
}