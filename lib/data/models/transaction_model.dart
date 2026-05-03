import 'package:hive/hive.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends TransactionEntity {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final double amount;
  
  @HiveField(3)
  final DateTime date;
  
  @HiveField(4)
  final String categoryId;
  
  @HiveField(5)
  final String typeString; // 'income' немесе 'expense'

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.typeString,
  }) : super(
          id: id,
          title: title,
          amount: amount,
          date: date,
          categoryId: categoryId,
          type: typeString == 'income' ? TransactionType.income : TransactionType.expense,
        );

  // Entity-ден Model-ге ауыстыру (Data Layer-ге дерек келгенде)
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      date: entity.date,
      categoryId: entity.categoryId,
      typeString: entity.type == TransactionType.income ? 'income' : 'expense',
    );
  }

  // ID-ді жаңарту үшін (мысалы, Uuid беру кезінде)
  TransactionModel copyWithId(String newId) {
    return TransactionModel(
      id: newId,
      title: title,
      amount: amount,
      date: date,
      categoryId: categoryId,
      typeString: typeString,
    );
  }
}