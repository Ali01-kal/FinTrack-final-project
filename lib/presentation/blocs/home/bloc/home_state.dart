part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final double income;
  final double expense;
  final double balance;
  final List<TransactionEntity> recentTransactions;

  const HomeLoaded({
    required this.income,
    required this.expense,
    required this.balance,
    required this.recentTransactions,
  });

  @override
  List<Object> get props => [income, expense, balance, recentTransactions];
}

final class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

