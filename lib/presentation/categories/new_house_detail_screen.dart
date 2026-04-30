import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewHouseDetailScreen extends StatelessWidget {
  const NewHouseDetailScreen({super.key});

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
        title: const Text('New House', 
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
          _buildHouseStats(),
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
                      _buildDepositItem('House Deposit', '19:56 - April 5', '\$477.77'),
                      
                      const SizedBox(height: 20),
                      
                      _buildSectionHeader('January'),
                      _buildDepositItem('House Deposit', '20:25 - January 16', '\$102.67'),
                      _buildDepositItem('House Deposit', '15:56 - January 02', '\$45.04'),
                      const SizedBox(height: 80),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    child: ElevatedButton(
                      onPressed: () => context.push('/addSavings'), // Add Savings-ке өту
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Add Savings', 
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

  Widget _buildHouseStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Goal', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 12)),
                  const Text('\$569,200', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Amount Saved', style: TextStyle(color: Color(0xFF1B3D3D), fontSize: 12)),
                  const Text('\$625.48', style: TextStyle(color: Color(0xFF00D19E), fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              // Көк шеңберлі прогресс блогы
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF8ECAFE),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        value: 0.3,
                        strokeWidth: 8,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_work_outlined, color: Colors.white, size: 30),
                        Text('House', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          // Төменгі прогресс бар
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.3,
              minHeight: 12,
              backgroundColor: const Color(0xFF00D19E),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1B3D3D)),
            ),
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

  Widget _buildDepositItem(String title, String time, String amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF42A5F5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)
            ),
            child: const Icon(Icons.home_work_outlined, color: Color(0xFF42A5F5)),
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
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(month, style: const TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
          const Icon(Icons.calendar_today_outlined, size: 18, color: Color(0xFF00D19E)),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      selectedItemColor: const Color(0xFF00D19E),
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
        if (index == 3) context.go('/categories');
      },
    );
  }
}