import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        title: const Text('Settings', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  _buildSettingItem(context, Icons.notifications_outlined, 'Notification Settings', () {
                    context.push('/notificationSettings');
                  }),
                  const SizedBox(height: 10),
                  _buildSettingItem(context, Icons.key_outlined, 'Password Settings', () {
                    context.push('/passwordSettings');
                  }),
                  const SizedBox(height: 10),
                  _buildSettingItem(context, Icons.person_outline, 'Delete Account', () {
                    context.push('/deleteAccount');
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSettingItem(
  BuildContext context,
  IconData icon,
  String title,
  VoidCallback onTap,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return ListTile(
    onTap: onTap,
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFF00D19E),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    ),
    title: Text(
      title,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 16,
      color: Color(0xFF1B3D3D),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  );
}

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4,
      selectedItemColor: const Color(0xFF00D19E),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
      onTap: (index) {
        if (index == 0) context.go('/home');
        if (index == 1) context.go('/analysis');
        if (index == 2) context.go('/transaction');
        if (index == 3) context.go('/categories');
        if (index == 4) context.go('/profile');
      },
    );
  }
}


