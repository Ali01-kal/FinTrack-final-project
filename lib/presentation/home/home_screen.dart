import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinTrack'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Жалпы баланс карточкасы (Заглушка)
          Card(
            margin: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: const Column(
                children: [
                  Text('Жалпы баланс', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('\$12,450.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Транзакциялар тізімі әзірге бос'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Транзакция қосу экранына өту (кейінірек)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}