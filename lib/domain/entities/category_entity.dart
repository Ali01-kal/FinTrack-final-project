class CategoryEntity {
  final String id;
  final String name;
  final String iconPath;
  final double? budgetLimit; 

  CategoryEntity({
    required this.id,
    required this.name,
    required this.iconPath,
    this.budgetLimit,
  });
}