import 'package:fintrack/core/widgets/savings_goal_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

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
              context.go('/categories'); // fallback route
            }
         }
        ),
        title: const Text('Car', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
      ),
      body: const SavingsGoalContent(
        title: 'Car',
        categoryId: 'car',
        goalAmount: 14390,
        icon: Icons.directions_car_filled_outlined,
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
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

