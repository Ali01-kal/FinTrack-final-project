class CategoriesViewState {
  const CategoriesViewState({
    required this.income,
    required this.expense,
    required this.balance,
    required this.progress,
  });

  final double income;
  final double expense;
  final double balance;
  final double progress;

  factory CategoriesViewState.initial() => const CategoriesViewState(
        income: 0,
        expense: 0,
        balance: 0,
        progress: 0,
      );
}
