import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Мазмұнына қарай биіктігін реттеу
            children: [
              const Text(
                'End Session',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3D3D),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              
              // "Yes, End Session" батырмасы
              ElevatedButton(
                onPressed: () {
                  // Сессияны аяқтау және Login бетіне бағыттау логикасы
                  context.go('/login'); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D19E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                ),
                child: const Text(
                  'Yes, End Session',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 10),
              
              // "Cancel" батырмасы
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F5E9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF1B3D3D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

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
        title: const Text('Profile', 
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
          // Профиль суреті (Аватар)
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: const NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1000&auto=format&fit=crop'), // Мысал ретінде
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text('John Smith', 
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
                        Text('ID: 25030024', 
                          style: TextStyle(fontSize: 12, color: Colors.black45)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildMenuItem(context, Icons.person_outline, 'Edit Profile', Colors.blue),
                
                  _buildMenuItem(context, Icons.settings_outlined, 'Setting', Colors.blue),
                  _buildMenuItem(context, Icons.headset_mic_outlined, 'Help', Colors.blue),
                  _buildMenuItem(context, Icons.logout_outlined, 'Logout', Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Color iconBgColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell( // Басу эффектісі үшін InkWell немесе GestureDetector қолданамыз
      onTap: () {
        if (title == 'Edit Profile') {
          context.push('/editProfile'); // Маршрутқа өту
        }
        if(title == 'Setting'){
          context.push('/settings');
        }
        if(title == 'Help'){
          context.push('/helpCenter');
        }
        if(title == 'Logout'){
          _showLogoutDialog(context);
        }
      },
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title, 
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600, 
                color: Color(0xFF1B3D3D)
              ),
            ),
          ),
          // Дизайн бойынша оң жаққа кішкене көрсеткіш қойып қоюға болады
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
        ],
      ),
    ),
  );
}

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4, // Профиль белсенді
      selectedItemColor: const Color(0xFF00D19E),
      unselectedItemColor: Colors.black26,
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
        if (index == 1) context.go('/analysis');
        if (index == 2) context.go('/transactions');
        if (index == 3) context.go('/categories');
        if (index == 4) context.go('/profile');
      },
    );
  }
}