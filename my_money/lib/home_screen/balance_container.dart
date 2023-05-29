import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';
import 'package:my_money/expense_chart/ExpenseChartScreen.dart';

class balanceContainer extends StatefulWidget {
  const balanceContainer({Key? key}) : super(key: key);

  @override
  State<balanceContainer> createState() => _balanceContainerState();
}

class _balanceContainerState extends State<balanceContainer> {
  TransactionsDB obj = TransactionsDB();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String expenseSum;

    return Container(
      margin: EdgeInsets.all(20),
      height: 200,
      width: 300,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 50.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 51, 130, 194),
              Color.fromARGB(255, 96, 195, 119),
            ],
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 40,
            child: Container(
              height: 80,
              width: 160,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 51, 130, 194),
                      Color.fromARGB(255, 96, 195, 119),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Balance',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade200),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.currency_rupee,
                        color: Colors.grey.shade200,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            obj.balanceAmount.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade200),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // incomecard
          Positioned(
            top: 10,
            left: 160,
            child: Container(
              height: 80,
              width: 140,
              padding: EdgeInsets.only(top: 0, left: 0, right: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 51, 130, 194),
                      Color.fromARGB(255, 96, 195, 119),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 132, 234, 92),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Income',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        Icons.currency_rupee,
                        color: Colors.grey.shade400,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            obj.sumOfIncomeAmount.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // expencecard
          Positioned(
            top: 110,
            left: 190,
            child: Container(
              height: 80,
              width: 140,
              padding: EdgeInsets.only(top: 0, left: 0, right: 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 51, 130, 194),
                      Color.fromARGB(255, 96, 195, 119),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 108, 79),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Expense',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Icon(
                        Icons.currency_rupee,
                        color: Colors.grey.shade400,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            obj.sumOfExpenseAmount.toString(),
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class chartButton extends StatelessWidget {
  const chartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: ElevatedButton.icon(
            icon: Icon(Icons.moving),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 53, 158, 244).withOpacity(0.2)),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExpenseChartScreen()));
              TransactionsDB.instance.dateForChartFunction();
            },
            label: Text(
              'Expense Chart',
              style: TextStyle(fontSize: 16),
            )),
      ),
    );
  }
}
