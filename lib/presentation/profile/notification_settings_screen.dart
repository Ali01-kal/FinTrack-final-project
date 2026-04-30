import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Ауыстырып-қосқыштардың күйін сақтайтын айнымалылар
  bool generalNotification = true;
  bool sound = true;
  bool soundCall = true;
  bool vibrate = true;
  bool transactionUpdate = false;
  bool expenseReminder = false;
  bool budgetNotifications = false;
  bool lowBalanceAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Жоғарғы жасыл бөлік
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text('Notification Settings', 
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)),
            onPressed: () {}, // Хабарламалар тарихын ашу логикасы
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Төменгі ақ бөлік
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6), // Сәл жасылдау ақ түс
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSwitchTile('General Notification', generalNotification, (val) {
                      setState(() => generalNotification = val);
                    }),
                    _buildSwitchTile('Sound', sound, (val) {
                      setState(() => sound = val);
                    }),
                    _buildSwitchTile('Sound Call', soundCall, (val) {
                      setState(() => soundCall = val);
                    }),
                    _buildSwitchTile('Vibrate', vibrate, (val) {
                      setState(() => vibrate = val);
                    }),
                    
                    // Бөлгіш сызық (опционалды, скриншотта жоқ, бірақ стиль үшін)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(color: Colors.black12, height: 1),
                    ),
                    
                    _buildSwitchTile('Transaction Update', transactionUpdate, (val) {
                      setState(() => transactionUpdate = val);
                    }),
                    _buildSwitchTile('Expense Reminder', expenseReminder, (val) {
                      setState(() => expenseReminder = val);
                    }),
                    _buildSwitchTile('Budget Notifications', budgetNotifications, (val) {
                      setState(() => budgetNotifications = val);
                    }),
                    _buildSwitchTile('Low Balance Alerts', lowBalanceAlerts, (val) {
                      setState(() => lowBalanceAlerts = val);
                    }),
                    
                    const SizedBox(height: 30), // Төменгі бос орын
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context), // Төменгі навигация
    );
  }

  // Әр хабарландыру жолына арналған виджет ( ListTile сияқты)
  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), // Жолдар арасындағы арақашықтық
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B3D3D), // Қара-жасыл түс
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF00D19E), // Қосулы кездегі жасыл түс
            activeTrackColor: const Color(0xFFE0F2F1), // Қосулы кездегі артқы түс
            inactiveThumbColor: Colors.white, // Өшірулі кездегі түс
            inactiveTrackColor: Colors.black12, // Өшірулі кездегі артқы түс
          ),
        ],
      ),
    );
  }

  // Төменгі навигациялық басылым (Басқа беттердегідей)
  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4, // Профиль бөлімі белсенді
      selectedItemColor: const Color(0xFF00D19E),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
      onTap: (index) {
        if (index == 0) context.go('/');
        // Басқа беттерге өту логикасы
      },
    );
  }
}