import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountBalanceScreen extends StatelessWidget {
  const AccountBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Негізгі жасыл фон
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Account Balance',
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
          const SizedBox(height: 10),
          
          // 1. Теңгерім мен Шығыс көрсеткіштері
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatInfo('Total Balance', '\$7,783.00', Colors.white),
                Container(width: 1, height: 40, color: Colors.white38),
                _buildStatInfo('Total Expense', '-\$1,187.40', const Color(0xFF1B3D3D)),
              ],
            ),
          ),

          // 2. Прогресс бар
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 12,
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: 12,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('\$20,000.00', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          // 3. Кіріс және Шығыс карталары (Ақ карталар)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                _buildSummaryCard('Income', '\$4,000.00', Icons.arrow_outward, const Color(0xFF00D19E)),
                const SizedBox(width: 15),
                _buildSummaryCard('Expense', '\$1,187.40', Icons.call_received, Colors.blueAccent),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('✅ 30% Of Your Expenses, Looks Good.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),

          // 4. Төменгі ақ блок (Транзакциялар тізімі)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: const Text('See all', style: TextStyle(color: Colors.black45))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      children: [
                        _buildTransactionItem('Salary', 'Monthly', '\$4,000,00', Icons.account_balance_wallet, Colors.blue),
                        _buildTransactionItem('Groceries', 'Pantry', '-\$100,00', Icons.shopping_bag, Colors.orange),
                        _buildTransactionItem('Rent', 'Rent', '-\$674,40', Icons.vpn_key, Colors.indigo),
                        _buildTransactionItem('Transport', 'Fuel', '-\$4,13', Icons.directions_bus, Colors.lightBlue),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00D19E),
        unselectedItemColor: Colors.black26,
        showSelectedLabels: false,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  // Көмекші: Кіріс/Шығыс картасы
  Widget _buildSummaryCard(String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color, width: 2)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color == Colors.blueAccent ? Colors.blueAccent : const Color(0xFF1B3D3D))),
          ],
        ),
      ),
    );
  }

  // Көмекші: Статистика мәтіні
  Widget _buildStatInfo(String title, String amount, Color amountColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.analytics_outlined, size: 14, color: Colors.black54),
            const SizedBox(width: 5),
            Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
        Text(amount, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: amountColor)),
      ],
    );
  }

  // Көмекші: Транзакция элементі
  Widget _buildTransactionItem(String title, String cat, String amount, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text('18:27 - April 30 | $cat', style: const TextStyle(color: Colors.black38, fontSize: 10)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold, color: amount.contains('-') ? Colors.blueAccent : Colors.black)),
        ],
      ),
    );
  }
}