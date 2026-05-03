class TransactionEntity {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String categoryId;
  final TransactionType type; // Income или Expense
  final String? note;

  TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.type,
    this.note,
  });
}

enum TransactionType { income, expense }