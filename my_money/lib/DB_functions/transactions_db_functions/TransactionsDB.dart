import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_money/const.dart';
import 'package:my_money/models/category/category.dart';
import 'package:my_money/models/transactions/transaction_model.dart';

abstract class transactionDBFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteTransaction(String categoryID);
}

class TransactionsDB implements transactionDBFunctions {
  ValueNotifier<List<TransactionModel>> allTransactionListener =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseTransactionListener =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeTransactionListener =
      ValueNotifier([]);
  List listExpenseAmount = [];
  dynamic sumOfExpenseAmount = 0;
  List listIncomeAmount = [];
  List listDate = [];
  dynamic sumOfIncomeAmount;
  dynamic balanceAmount;
  List listexpenseDate = [];
  List allTransactionsList = [];
  List searchList = [];

  TransactionsDB.internal();
  static TransactionsDB instance = TransactionsDB.internal();
  factory TransactionsDB() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final transactionsDB =
        await Hive.openBox<TransactionModel>(TRANSACTIONS_BOX_NAME);
    await transactionsDB.put(obj.id, obj);
    refreshUIseparatedList();
    refreshUIFullList();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final transactionsDB =
        await Hive.openBox<TransactionModel>(TRANSACTIONS_BOX_NAME);
    return transactionsDB.values.toList();
  }

  Future<void> refreshUIFullList() async {
    final fullList = await getTransactions();
    fullList.sort((first, second) => second.date.compareTo(first.date));
    allTransactionListener.value.clear();
    await Future.forEach(fullList, (TransactionModel transaction) {
      allTransactionListener.value.add(transaction);
      allTransactionListener.notifyListeners();
    });
  }

  Future<void> refreshUIseparatedList() async {
    final fullList = await getTransactions();
    fullList.sort((first, second) => second.date.compareTo(first.date));
    incomeTransactionListener.value.clear();
    expenseTransactionListener.value.clear();
    await Future.forEach(fullList, (TransactionModel transaction) {
      if (transaction.type == CategoryType.income) {
        incomeTransactionListener.value.add(transaction);
      }
      if (transaction.type == CategoryType.expense) {
        expenseTransactionListener.value.add(transaction);
      }
      incomeTransactionListener.notifyListeners();
      expenseTransactionListener.notifyListeners();
    });
  }

  @override
  Future<void> deleteTransaction(String ID) async {
    final transactionsDB =
        await Hive.openBox<TransactionModel>(TRANSACTIONS_BOX_NAME);
    await transactionsDB.delete(ID);
    refreshUIseparatedList();
    refreshUIFullList();
  }

  Future<void> expenseTotalAmountFunction() async {
    listExpenseAmount.clear();
    allTransactionsList.clear();
    final expenseAmountList = await getTransactions();
    await Future.forEach(expenseAmountList, (TransactionModel expenseAmount) {
      allTransactionsList.add(expenseAmount.amount);
      if (expenseAmount.type == CategoryType.expense) {
        listExpenseAmount.add(expenseAmount.amount);
      } else {
        // return;
      }
    });
    sumOfExpenseAmount = 0;
    for (int i = 0; i < listExpenseAmount.length; i++) {
      sumOfExpenseAmount = listExpenseAmount[i] + sumOfExpenseAmount;
    }
  }

  Future<void> sumOfIncomeAmountFunction() async {
    listIncomeAmount.clear();
    final listOfIncome = await getTransactions();
    await Future.forEach(listOfIncome, (TransactionModel incomeAmount) {
      if (incomeAmount.type == CategoryType.income) {
        listIncomeAmount.add(incomeAmount.amount);
      } else {
        // return;
      }
    });
    sumOfIncomeAmount = 0;
    for (int i = 0; i < listIncomeAmount.length; i++) {
      sumOfIncomeAmount = listIncomeAmount[i] + sumOfIncomeAmount;
    }
    balanceAmount = 0;
    balanceAmount = sumOfIncomeAmount - sumOfExpenseAmount;
  }

  Future<void> dateForChartFunction() async {
    listDate.clear();
      listDate.sort((first, second) => second.date.compareTo(first.date));
    final listDateTemp = await getTransactions();
    await Future.forEach(listDateTemp, (TransactionModel date) { 
      if (date.type == CategoryType.expense) {
        listDate.add(date.date);
      }
    });
  }

  Future<void> editTransactions(TransactionModel obj, id) async {
    final transactionsDB =
        await Hive.openBox<TransactionModel>(TRANSACTIONS_BOX_NAME);
    await transactionsDB.put(id, obj);
    refreshUIseparatedList();
    refreshUIFullList();
  }

  Future<void> searchListFunction() async {
    listDate.clear();
    final listDateTemp = await getTransactions();
    await Future.forEach(listDateTemp, (TransactionModel date) {
      searchList.add(date);
    });
  }
}
