import 'package:flutter/material.dart';
import '../utils/currency_formatter.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String category;
  final double amount;
  final bool isExpense;
  final String iconPath;

  const TransactionCard({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.isExpense,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: Image.asset(iconPath, width: 24), // Иконка
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(category, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text(
            isExpense ? "- ${CurrencyFormatter.format(amount)}" : "+ ${CurrencyFormatter.format(amount)}",
            style: TextStyle(
              color: isExpense ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
//toKzt