import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(1)
  income,

  @HiveField(2)
  expense,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String categoryName;

  @HiveField(2)
  final CategoryType type;

  @HiveField(3)
  final bool? isDeleted;

  CategoryModel({
    required this.categoryName,
    required this.type,
    this.isDeleted = false,
    required this.id,
  });
}
