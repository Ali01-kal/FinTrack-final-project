import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool isSpendsSelected = true; // "Spends" немесе "Categories" таңдау үшін

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
        title: const Text('Calender', 
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
          const SizedBox(height: 10),
          // Ақ блок (Күнтізбе мен мазмұн)
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
                  children: [
                    // 1. Күнтізбе блогы
                    _buildCalendarCard(),

                    const SizedBox(height: 25),

                    // 2. Custom Switcher (Spends / Categories)
                    _buildTabSwitcher(),

                    const SizedBox(height: 25),

                    // 3. Мазмұны (Тізім немесе Диаграмма)
                    isSpendsSelected ? _buildSpendsList() : _buildCategoriesChart(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // Күнтізбе виджеті
  Widget _buildCalendarCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDropdownText('April'),
              _buildDropdownText('2023'),
            ],
          ),
          const SizedBox(height: 20),
          // Күндер кестесі (Дизайндағыдай қарапайым нұсқасы)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((d) => Text(d, style: const TextStyle(color: Colors.blueAccent, fontSize: 10))).toList(),
          ),
          const SizedBox(height: 10),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildDropdownText(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: Color(0xFF00D19E), fontWeight: FontWeight.bold)),
        const Icon(Icons.keyboard_arrow_down, color: Color(0xFF00D19E), size: 18),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    // Бұл жерде нақты GridView қолдануға болады, бірақ дизайндағыдай статикалық күндер:
    return Column(
      children: List.generate(5, (row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (col) {
              int day = (row * 7) + col + 1;
              return SizedBox(
                width: 25,
                child: Text(day > 31 ? "" : "$day", 
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF1B3D3D))),
              );
            }),
          ),
        );
      }),
    );
  }

  // Ауыстырып қосқыш (Switch)
  Widget _buildTabSwitcher() {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF00D19E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          _buildTabButton('Spends', isSpendsSelected),
          _buildTabButton('Categories', !isSpendsSelected),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isSpendsSelected = title == 'Spends'),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(title, 
            style: TextStyle(color: isSelected ? Colors.white : Colors.black45, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // Шығындар тізімі (Spends)
  Widget _buildSpendsList() {
    return Column(
      children: [
        _buildTransactionItem('Groceries', '17:00 - April 24', '-\$100,00', Icons.shopping_basket_outlined, Colors.blue),
        const SizedBox(height: 15),
        _buildTransactionItem('Others', '17:00 - April 24', '\$120,00', Icons.layers_outlined, Colors.blue),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount, IconData icon, Color color) {
    return Container(
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
                Text(date, style: const TextStyle(color: Colors.black26, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
        ],
      ),
    );
  }

  // Категориялар диаграммасы (Categories)
  Widget _buildCategoriesChart() {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Дизайн бойынша жартылай дөңгелек диаграмма (CustomPaint немесе сурет)
        Container(
          height: 150,
          width: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/chart_placeholder.png'), // Диаграмма суретін қоюға болады
              fit: BoxFit.contain,
            ),
          ),
          child: Center(child: Text("79%", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue.shade700))),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChartLegend('Groceries', Colors.blue),
            const SizedBox(width: 20),
            _buildChartLegend('Others', Colors.blueAccent),
          ],
        )
      ],
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      selectedItemColor: const Color(0xFF00D19E),
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