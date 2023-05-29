import 'package:flutter/material.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/models/category/category.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

ValueNotifier<CategoryType> selectedCategoryIndex =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryPopUp(BuildContext context) async {
  final _categoryEditingController = TextEditingController();
  showDialog(
      context: (context),
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add Category'),
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: _categoryEditingController,
                decoration: InputDecoration(
                    hintText: 'Add Category',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            CategoryPopUp(
              title: 'Income',
              type: CategoryType.income,
            ),
            CategoryPopUp(
              title: 'Expense',
              type: CategoryType.expense,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      final _categoryName = _categoryEditingController.text;
                      if (_categoryName.isEmpty) {
                        return;
                      }
                      final _type = selectedCategoryIndex.value;
                      final _category = CategoryModel(
                          categoryName: _categoryName,
                          type: _type,
                          id: DateTime.now().millisecondsSinceEpoch.toString());
                      categoryDB.instance.insertCategory(_category);
                      categoryDB.instance.allCategoryListFunction();
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Add')))
          ],
        );
      });
}

class CategoryPopUp extends StatelessWidget {
  CategoryPopUp(
      {Key? key,
      required this.title,
      required this.type,
      this.selectedCategoryType})
      : super(key: key);
  final String title;
  final CategoryType type;
  final CategoryType? selectedCategoryType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ValueListenableBuilder(
              valueListenable: selectedCategoryIndex,
              builder: (BuildContext context, dynamic newCategory, Widget? _) {
                return Radio<CategoryType>(
                    activeColor: Colors.blue.shade900,
                    value: type,
                    groupValue: newCategory,
                    onChanged: ((value) {
                      print(value);
                      if (value == null) {
                        return;
                      }
                      selectedCategoryIndex.value = value;
                      selectedCategoryIndex.notifyListeners();
                    }));
              },
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
