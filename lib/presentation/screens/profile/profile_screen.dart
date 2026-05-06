import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/auth/auth_event.dart';
import 'package:fintrack/presentation/blocs/auth/auth_state.dart';
import 'package:fintrack/presentation/blocs/export/bloc/export_bloc.dart';
import 'package:fintrack/presentation/blocs/export/bloc/export_event.dart';
import 'package:fintrack/presentation/blocs/export/bloc/export_state.dart';

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
            mainAxisSize: MainAxisSize.min,
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
          
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthSignOutRequested());
                  Navigator.pop(context);
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              context.go('/login');
            }
          },
        ),
        BlocListener<ExportBloc, ExportState>(
          listener: (context, state) {
            if (state is ExportSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('PDF dayyn: ${state.filePath}')),
              );
            }
            if (state is ExportError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
        title: Text('Profile', 
          style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          BlocBuilder<ExportBloc, ExportState>(
            builder: (context, state) {
              final isLoading = state is ExportLoading;
              return IconButton(
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.picture_as_pdf_outlined,
                        color: isDark ? Colors.white : const Color(0xFF1B3D3D),
                      ),
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<ExportBloc>().add(ExportToPdfRequested());
                      },
                tooltip: 'PDF Export',
              );
            },
          ),
          
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
         
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage("assets/images/avatar_photo.png"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final name = state is Authenticated
                          ? (state.user.name?.trim().isNotEmpty == true ? state.user.name! : state.user.email)
                          : 'Guest';
                      final id = state is Authenticated ? state.user.id : '-';
                      return Center(
                        child: Column(
                          children: [
                            Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1B3D3D))),
                            Text('ID: $id', style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.black45)),
                          ],
                        ),
                      );
                    },
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
    ));
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Color iconBgColor) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell( 
      onTap: () {
        if (title == 'Edit Profile') {
          context.push('/editProfile'); 
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
              style:  TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600, 
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          
          Icon(Icons.arrow_forward_ios, size: 16, color: isDark ? Colors.white38 : Colors.black26),
        ],
      ),
    ),
  );
}

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4, 
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
        if (index == 0) context.go('/home');
        if (index == 1) context.go('/analysis');
        if (index == 2) context.go('/transaction');
        if (index == 3) context.go('/categories');
        if (index == 4) context.go('/profile');
      },
    );
  }
}

