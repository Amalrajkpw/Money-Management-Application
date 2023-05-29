import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_money/const.dart';
 
import 'package:my_money/models/category/category.dart';

abstract class categoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class categoryDB implements categoryDbFunctions {
  List listAllCategory = [];
  categoryDB._internal();
  static categoryDB instance = categoryDB._internal();
  factory categoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListNotifier =
      ValueNotifier([]);
  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_BOX_NAME);
    return categoryDB.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_BOX_NAME);
    await categoryDB.put(value.id, value);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();

    incomeCategoryListNotifier.value.clear();

    expenseCategoryListNotifier.value.clear();

    await Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListNotifier.value.add(category);
      } else {
        expenseCategoryListNotifier.value.add(category);
      }
    });

    incomeCategoryListNotifier.notifyListeners();

    expenseCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_BOX_NAME);

    await _categoryDB.delete(categoryID);

    refreshUI();
  }

  Future<void> allCategoryListFunction() async {
    listAllCategory.clear();
    final listDateTemp = await getCategories();
    await Future.forEach(listDateTemp, (CategoryModel incomeCategory) {
      listAllCategory.add(incomeCategory.categoryName);
    });
  }
}
