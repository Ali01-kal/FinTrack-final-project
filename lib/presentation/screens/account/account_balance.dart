import 'package:flutter/material.dart';

class AccountBalanceScreen extends StatelessWidget {
  const AccountBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account Balance')),
      body: const Center(child: Text('Account balance details')),
    );
  }
}
