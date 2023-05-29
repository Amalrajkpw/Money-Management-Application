import 'package:hive/hive.dart';
import 'package:my_money/models/category/category.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel extends HiveObject {
  @HiveField(1)
  String description;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final CategoryType type;

  @HiveField(5)
  final CategoryModel category;

  @HiveField(6)
  final String id;
  TransactionModel(
      {required this.amount,
      required this.category,
      required this.date,
      required this.description,
      required this.type,
      required this.id}) {
    // id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
