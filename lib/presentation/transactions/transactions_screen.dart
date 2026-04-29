import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // 0: Барлығы (Transactions), 1: Тек Income, 2: Тек Expense
  int activeFilter = 0; 

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
        title: const Text('Transaction', 
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
          // 1. Жалпы баланс картасы
          _buildBalanceCard(),
          
          const SizedBox(height: 20),

          // 2. Income & Expense батырмалары (Сүзгілер)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                _buildFilterButton('Income', '\$4,120.00', Icons.arrow_outward, 1),
                const SizedBox(width: 15),
                _buildFilterButton('Expense', '\$1,187.40', Icons.call_received, 2),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 3. Төменгі ақ тізім бөлімі
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
                child: ListView(
                  padding: const EdgeInsets.all(25),
                  children: _buildTransactionList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Жалпы баланс виджеті
  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Text('Total Balance', style: TextStyle(color: Colors.black45, fontSize: 14)),
          const SizedBox(height: 5),
          const Text('\$7,783.00', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
        ],
      ),
    );
  }

  // Income / Expense сүзгі батырмалары
  Widget _buildFilterButton(String title, String amount, IconData icon, int filterIndex) {
    bool isSelected = activeFilter == filterIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            // Егер бұрын таңдалған болса, қайта басса барлық транзакцияға қайтады (Toggle)
            activeFilter = isSelected ? 0 : filterIndex;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2196F3) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.white : const Color(0xFF00D19E), size: 20),
              const SizedBox(height: 5),
              Text(title, style: TextStyle(color: isSelected ? Colors.white70 : Colors.black45, fontSize: 12)),
              Text(amount, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  // Деректерді сүзіп шығару логикасы
  List<Widget> _buildTransactionList() {
    List<Widget> list = [];

    // "April" бөлімі
    list.add(_buildSectionHeader('April'));

    // Income деректері (activeFilter 0 немесе 1 болғанда көрінеді)
    if (activeFilter == 0 || activeFilter == 1) {
      list.add(_buildItem('Salary', '18:27 - April 30', 'Monthly', '\$4.000,00', Icons.account_balance_wallet_outlined, Colors.blue, false));
    }

    // Expense деректері (activeFilter 0 немесе 2 болғанда көрінеді)
    if (activeFilter == 0 || activeFilter == 2) {
      list.add(_buildItem('Groceries', '17:00 - April 24', 'Pantry', '-\$100,00', Icons.shopping_basket_outlined, Colors.blue, true));
      list.add(_buildItem('Rent', '8:30 - April 15', 'Rent', '-\$674,40', Icons.vpn_key_outlined, Colors.blue, true));
    }

    list.add(const SizedBox(height: 20));
    
    // "March" бөлімі
    list.add(_buildSectionHeader('March'));
    if (activeFilter == 0 || activeFilter == 2) {
      list.add(_buildItem('Food', '19:30 - March 31', 'Dinner', '-\$70,40', Icons.restaurant_outlined, Colors.blue, true));
    }

    return list;
  }

  Widget _buildSectionHeader(String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(month, style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold)),
          const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF00D19E)),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String time, String category, String amount, IconData icon, Color color, bool isExpense) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: Icon(icon, color: color),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(category, style: const TextStyle(color: Colors.black26, fontSize: 11)),
              Text(amount, style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: isExpense ? Colors.blue : const Color(0xFF1B3D3D)
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 2, // Transaction белсенді
      selectedItemColor: const Color(0xFF00D19E),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''), // Transaction ортада
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
      onTap: (index) {
        if (index == 0) context.go('/');
        if (index == 1) context.go('/analysis');
      },
    );
  }
}