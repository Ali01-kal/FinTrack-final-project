import 'package:fintrack/presentation/blocs/auth/auth_bloc.dart';
import 'package:fintrack/presentation/blocs/auth/auth_event.dart';
import 'package:fintrack/presentation/blocs/auth/auth_state.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_bloc.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_event.dart';
import 'package:fintrack/presentation/blocs/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool pushNotifications = true;
  bool darkTheme = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    if (state is Authenticated) {
      _nameController.text = state.user.name ?? '';
      _emailController.text = state.user.email;
    }
    final themeState = context.read<ThemeBloc>().state;
    darkTheme = themeState.themeMode == ThemeMode.dark;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final state = context.read<AuthBloc>().state;
    if (state is! Authenticated) return;
    context.read<AuthBloc>().add(
          AuthProfileUpdateRequested(
            name: _nameController.text,
            email: _emailController.text,
          ),
        );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated')));
    context.pop();
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
          onPressed: () {
            if (context.canPop()) {
              context.pop();
             } else {
              context.go('/profile'); // fallback route
            }
         }
        ),
        title: const Text('Edit My Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(radius: 55, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEditField('Username', _nameController),
                    const SizedBox(height: 15),
                    _buildEditField('Phone', _phoneController),
                    const SizedBox(height: 15),
                    _buildEditField('Email Address', _emailController),
                    const SizedBox(height: 20),
                    _buildSwitchRow('Push Notifications', pushNotifications, (val) => setState(() => pushNotifications = val)),
                    _buildSwitchRow('Turn Dark Theme', darkTheme, (val) {
                      setState(() => darkTheme = val);
                      context.read<ThemeBloc>().add(ThemeChanged(isDark: val));
                    }),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        ),
                        child: const Text('Update Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  

  Widget _buildEditField(String label, TextEditingController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ?  Colors.white : Colors.black)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)),
          child: TextField(controller: controller, decoration: const InputDecoration(border: InputBorder.none)),
        ),
      ],
    );
  }

  Widget _buildSwitchRow(String title, bool value, Function(bool) onChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ?  Colors.white : Colors.black)),
        Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF00D19E)),
      ],
    );
  }
}
