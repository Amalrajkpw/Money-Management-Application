import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:my_money/add_transactions/add_transaction.dart';

import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';
import 'package:my_money/edit_transactions/edit_transactions_screen.dart';
import 'package:my_money/home_screen/recent_transactions.dart';
import 'package:my_money/models/category/category.dart';
import 'package:my_money/models/transactions/transaction_model.dart';
 
import 'package:my_money/transactions_detail_page/transaction_detail_page.dart';

class historyScreen extends StatefulWidget {
  historyScreen({Key? key}) : super(key: key);

  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen>
    with TickerProviderStateMixin {
  String search = "";
  @override
  Widget build(BuildContext context) {
    TransactionsDB.instance.refreshUIseparatedList();
    TabController _tabControllerHistory = TabController(length: 3, vsync: this);
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search Transactions ',
                hintStyle: TextStyle(
                    color: Color.fromARGB(255, 37, 124, 168),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 79, 147, 216),
                  size: 29,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 169, 210, 244),
              ),
              onChanged: ((value) {
                setState(() {
                  search = value;
                });
              }),
            ),
          ),
        ),
        SizedBox(
          height: 0,
        ),
      
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: Color.fromARGB(255, 42, 127, 196).withOpacity(0.3),
          ),
          child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue.shade600,
              ),
              isScrollable: true,
              labelPadding: EdgeInsets.only(left: 30, right: 30),
              unselectedLabelColor: Color.fromARGB(255, 45, 43, 43),
              controller: _tabControllerHistory,
              tabs: [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                )
              ]),
        ),
        Expanded(
          child: TabBarView(controller: _tabControllerHistory, children: [
            // All Transactions'
            ValueListenableBuilder(
                valueListenable: TransactionsDB.instance.allTransactionListener,
                builder: (BuildContext context, List<TransactionModel> newList,
                    Widget? _) {
                  List<TransactionModel> searchList = search.isEmpty
                      ? newList.toList()
                      : newList
                          .where((element) => element.category.categoryName
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                          .toList();
                  return newList.isEmpty
                      ? Lottie.asset('animations/not_found_blue.json')
                      : ListView.builder(
                          itemCount: searchList.length,
                          itemBuilder: ((context, index) {
                            final allTransactions = searchList[index];
                            return Slidable(
                              key: const ValueKey(0),
                              startActionPane:
                                  ActionPane(motion: ScrollMotion(), children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    log("id : ${allTransactions.id}");
                                    TransactionsDB.instance
                                        .deleteTransaction(allTransactions.id);

                                    setState(() {
                                      TransactionsDB.instance
                                          .expenseTotalAmountFunction();
                                      TransactionsDB.instance
                                          .sumOfIncomeAmountFunction();
                                    });
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  backgroundColor: Colors.grey.withOpacity(0.3),
                                  foregroundColor: Colors.red ,
                                ),
                                SlidableAction(
                                  onPressed: ((context) {
                                    log(" Id : ${allTransactions.id}");
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return editTransactionsScreen(
                                        Notes: allTransactions.description,
                                        amount: allTransactions.amount.toString(),
                                        category: allTransactions
                                            .category.categoryName,
                                        date: allTransactions.date,
                                        id: allTransactions.id,
                                        type: allTransactions.type,
                                        transaction: allTransactions,
                                      );
                                    }));
                                  }),
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  backgroundColor: Colors.grey.withOpacity(0.3),
                                  foregroundColor: Color.fromARGB(255, 17, 2, 226),
                                ),
                              ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Card(
                                  shape: RoundedRectangleBorder( 
                                    //<-- SEE HERE

                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(255, 119, 187, 243),
                                            Color.fromARGB(255, 224, 226, 226),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: ListTile(
                                      onTap: (() {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              transactionsDetails(
                                                  transaction: allTransactions),
                                        ));
                                      }),
                                      leading: Container(
                                        height: 20,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: allTransactions.type ==
                                                    CategoryType.income
                                                ? Colors.green
                                                : Colors.red),
                                        child: Text(
                                          'Cash',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade300),
                                        ),
                                      ),
                                      title: Text(
                                        allTransactions.category.categoryName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Container(
                                        child: Text(
                                          dateParse(allTransactions.date),
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                      ),
                                      trailing: Wrap(
                                        spacing: 12, // space between two icons
                                        children: <Widget>[
                                          Icon(Icons.currency_rupee),
                                          Text(
                                            allTransactions.amount.toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }));
                }),
            // Income Transactions
            ValueListenableBuilder(
                valueListenable:
                    TransactionsDB.instance.incomeTransactionListener,
                builder: (BuildContext context, List<TransactionModel> newList,
                    Widget? _) {
                  return ListView.builder(
                      itemCount: newList.length,
                      itemBuilder: ((context, index) {
                        final incomeCategory = newList[index];
                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                TransactionsDB.instance
                                    .deleteTransaction(incomeCategory.id);

                                setState(() {
                                  TransactionsDB.instance
                                      .expenseTotalAmountFunction();
                                  TransactionsDB.instance
                                      .sumOfIncomeAmountFunction();
                                });
                              },
                              icon: Icons.delete,
                              label: 'Delete',
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              foregroundColor: Colors.red ,
                            )
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                //<-- SEE HERE

                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromARGB(255, 119, 187, 243),
                                        Color.fromARGB(255, 224, 226, 226),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16)),
                                child: ListTile(
                                  onTap: (() {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => transactionsDetails(
                                          transaction: incomeCategory),
                                    ));
                                  }),
                                  leading: Container(
                                    height: 20,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.green),
                                    child: Text(
                                      'Cash',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  title: Text(
                                    incomeCategory.category.categoryName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Container(
                                    child: Text(
                                      dateParse(incomeCategory.date),
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                  trailing: Wrap(
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      Icon(Icons.currency_rupee),
                                      Text(
                                        incomeCategory.amount.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }));
                }),
            //  Expense Transactions
            ValueListenableBuilder(
                valueListenable:
                    TransactionsDB.instance.expenseTransactionListener,
                builder: (BuildContext context,
                    List<TransactionModel> newListExpense, Widget? _) {
                  return ListView.builder(
                      itemCount: newListExpense.length,
                      itemBuilder: ((context, index) {
                        final expenseCategory = newListExpense[index];
                        return Slidable(
                          key: const ValueKey(0),
                          startActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              onPressed: (context) {
                                TransactionsDB.instance
                                    .deleteTransaction(expenseCategory.id);
                                setState(() {
                                  TransactionsDB.instance
                                      .expenseTotalAmountFunction();
                                  TransactionsDB.instance
                                      .sumOfIncomeAmountFunction();
                                });
                              },
                              icon: Icons.delete,
                              label: 'Delete',
                              backgroundColor: Colors.grey.withOpacity(0.3),
                              foregroundColor: Colors.red,
                            )
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                //<-- SEE HERE

                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromARGB(255, 119, 187, 243),
                                        Color.fromARGB(255, 224, 226, 226),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16)),
                                child: ListTile(
                                  onTap: (() {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => transactionsDetails(
                                          transaction: expenseCategory),
                                    ));
                                  }),
                                  leading: Container(
                                    height: 20,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.red),
                                    child: Text(
                                      'Cash',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  title: Text(
                                    expenseCategory.category.categoryName
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Container(
                                    child: Text(
                                      dateParse(expenseCategory.date),
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                  trailing: Wrap(
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      Icon(Icons.currency_rupee),
                                      Text(
                                        expenseCategory.amount.toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }));
                }),
          ]),
        )
      ],
    );
  }
}
