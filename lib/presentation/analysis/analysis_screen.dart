import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String selectedPeriod = 'Weekly';

  // Дизайнға сәйкес нақты деректер
  final Map<String, Map<String, dynamic>> periodData = {
    'Daily': {
      'income': '\$4,120.00',
      'expense': '\$1,187.40',
      'bars': [40.0, 70.0, 50.0, 90.0, 60.0, 80.0, 45.0],
      'labels': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    'Weekly': {
      'income': '\$11,420.00',
      'expense': '\$20,000.20',
      'bars': [50.0, 90.0, 65.0, 85.0],
      'labels': ['1st Week', '2nd Week', '3rd Week', '4th Week']
    },
    'Monthly': {
      'income': '\$47,200.00',
      'expense': '\$35,510.20',
      'bars': [60.0, 40.0, 90.0, 70.0, 55.0, 80.0],
      'labels': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    },
    'Year': {
      'income': '\$430,560.00',
      'expense': '\$320,300.00',
      'bars': [50.0, 70.0, 95.0, 60.0, 85.0],
      'labels': ['2019', '2020', '2021', '2022', '2023']
    },
  };

  @override
  Widget build(BuildContext context) {
    var currentData = periodData[selectedPeriod]!;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text('Analysis', 
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: Column(
        children: [
          // 1. Жоғарғы статистикалық блок (Total Balance & Expense)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTopStat('Total Balance', '\$7,783.00', Icons.account_balance_wallet_outlined),
                    _buildTopStat('Total Expense', '-\$1,187.40', Icons.analytics_outlined),
                  ],
                ),
                const SizedBox(height: 15),
                // Прогресс-бар (дизайндағыдай)
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 8,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30%', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 10, fontWeight: FontWeight.bold)),
                    Text('\$20,000.00', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('✓ 30% Of Your Expenses, Looks Good.', 
                    style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 10)),
                ),
              ],
            ),
            
          ),

          // 2. Period Selector
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Daily', 'Weekly', 'Monthly', 'Year'].map((period) {
                bool isSelected = selectedPeriod == period;
                return GestureDetector(
                  onTap: () => setState(() => selectedPeriod = period),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF00D19E) : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      period,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF1B3D3D).withOpacity(0.6),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 15),

          // 3. Ақ блок (График және Карталар)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Income & Expenses', 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
                        Row(
                          children: [
                            _buildSmallIcon(
                              Icons.search,
                              () => context.push('/search'),
                            ),
                            const SizedBox(width: 8),
                            _buildSmallIcon(
                              Icons.calendar_today_outlined,
                              () => context.push('/calendar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    
                    // График
                    _buildDynamicChart(currentData),

                    const SizedBox(height: 35),

                    // Income & Expense карталары
                    Row(
                      children: [
                        _buildStatCard('Income', currentData['income'], Icons.arrow_outward, const Color(0xFF00D19E)),
                        const SizedBox(width: 15),
                        _buildStatCard('Expense', currentData['expense'], Icons.call_received, Colors.blueAccent),
                      ],
                    ),

                    const SizedBox(height: 30),
                    const Text('My Targets', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
                    const SizedBox(height: 15),
                    // Қосымша транзакциялар немесе мақсаттар осында
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStat(String title, String amount, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF1B3D3D)),
            const SizedBox(width: 4),
            Text(title, style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 11)),
          ],
        ),
        const SizedBox(height: 4),
        Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ],
    );
  }

  Widget _buildSmallIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00D19E).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF00D19E)),
        
      ),
    );
  }

  Widget _buildDynamicChart(Map<String, dynamic> data) {
    List<double> barHeights = data['bars'];
    List<String> labels = data['labels'];

    return Container(
      height: 200,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(barHeights.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: barHeights[index] * 1.5, // Биіктік масштабы
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? const Color(0xFF00D19E) : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              Text(labels[index], style: const TextStyle(fontSize: 9, color: Colors.black45)),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            const SizedBox(height: 4),
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B3D3D))),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1, // Analysis белсенді болып тұруы керек
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
        if (index == 0) context.go('/home'); // Home-ға қайту үшін
      },
    );
  }
}