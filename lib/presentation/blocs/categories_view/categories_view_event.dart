import 'package:fintrack/domain/entities/transaction_entity.dart';

abstract class CategoriesViewEvent {}

class CategoriesViewSyncRequested extends CategoriesViewEvent {
  CategoriesViewSyncRequested(this.transactions);
  final List<TransactionEntity> transactions;
}
