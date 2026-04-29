import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          'Notification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6), // Ақшыл фон
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: ListView(
                padding: const EdgeInsets.all(25),
                children: [
                  _buildSectionHeader('Today'),
                  _buildNotificationItem(
                    icon: Icons.notifications,
                    title: 'Reminder!',
                    description: 'Set up your automatic savings to meet your savings goal...',
                    time: '17:00 - April 24',
                    iconColor: Colors.amber,
                  ),
                  _buildNotificationItem(
                    icon: Icons.star,
                    title: 'New Update',
                    description: 'Set up your automatic savings to meet your savings goal...',
                    time: '17:00 - April 24',
                    iconColor: Colors.amber,
                  ),
                  
                  const SizedBox(height: 20),
                  _buildSectionHeader('Yesterday'),
                  _buildNotificationItem(
                    icon: Icons.attach_money,
                    title: 'Transactions',
                    description: 'A new transaction has been registered',
                    subDescription: 'Groceries | Pantry | -\$100,00',
                    time: '17:00 - April 24',
                    iconColor: Colors.amber,
                  ),
                  _buildNotificationItem(
                    icon: Icons.notifications,
                    title: 'Reminder!',
                    description: 'Set up your automatic savings to meet your savings goal...',
                    time: '17:00 - April 24',
                    iconColor: Colors.amber,
                  ),

                  const SizedBox(height: 20),
                  _buildSectionHeader('This Weekend'),
                  _buildNotificationItem(
                    icon: Icons.call_received,
                    title: 'Expense Record',
                    description: 'We recommend that you be more attentive to your finances.',
                    time: '17:00 - April 24',
                    iconColor: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Бөлім тақырыбы (Today, Yesterday...)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Хабарлама элементі
  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String description,
    String? subDescription,
    required String time,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  if (subDescription != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      subDescription,
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(time, style: const TextStyle(color: Colors.blueAccent, fontSize: 11)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(color: Colors.black12, thickness: 1),
        ),
      ],
    );
  }
}