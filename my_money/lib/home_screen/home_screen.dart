import 'dart:ffi';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_money/add_transactions/add_transaction.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';

import 'package:my_money/widgets/animations.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:my_money/add_category/add_category_screen.dart';

import 'package:my_money/history_screen/history_screen.dart';
import 'package:my_money/home_screen/balance_container.dart';
import 'package:my_money/home_screen/recent_transactions.dart';

import 'package:my_money/category_list/category_list_screen.dart';

import '../expense_chart/ExpenseChartScreen.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int categoryRadioValue = 0;
  int bottomNavIndex = 0;
  late PageController _pageController;
  TooltipBehavior? _tooltipBehavior;

  TransactionsDB obj = TransactionsDB();
  @override
  void initState() {
    categoryDB.instance.allCategoryListFunction();

    setState(() {
      obj.expenseTotalAmountFunction();
      obj.sumOfIncomeAmountFunction();
      obj.refreshUIFullList();
      obj.refreshUIseparatedList();
    });
    super.initState();

    _pageController = PageController();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          title: Text(
            'My Money',
            style: GoogleFonts.mukta(
                fontSize: 20,
                fontWeight: FontWeight.bold  ,
                color: Colors.blue.shade100),
          ),
          backgroundColor: Color.fromARGB(255, 8, 85, 147),
          centerTitle: true,
          leading: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.currency_rupee_sharp)
            ],
          )),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: const Duration(milliseconds: 1000),
          backgroundColor: Colors.white.withOpacity(0.3),
          content: Text(
            'Tap back again to exit  ',
            style: TextStyle(
              color: Color.fromARGB(255, 8, 85, 147),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavIndex = index;
              });
            },
            children: [
              // Homescreen
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/background.jpg'),
                        fit: BoxFit.cover)),
                child: ListView(
                  children: [
                    balanceContainer(),
                    chartButton(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 10),
                      child: TransactionsDB
                              .instance.allTransactionListener.value.isEmpty
                          ? transactionNotFoundText()
                          : Text(
                              'Recent Transactions',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade300),
                            ),
                    ),
                    TransactionsDB.instance.allTransactionListener.value.isEmpty
                        ? Center(
                            child: Lottie.asset('animations/not_found.json'))
                        : recentTransactions(),
                  ],
                ),
              ),
              //  HistoryScreen

              Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/category_background.jpeg'),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 233, 238, 242),
                        Color.fromARGB(255, 108, 182, 238),
                      ],
                    )),
                child: historyScreen(),
              ),
              // categoryScreen
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/category_background.jpeg'),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 233, 238, 242),
                        Color.fromARGB(255, 108, 182, 238),
                      ],
                    )),
                child: tabBarWidget(),
              ),
              //  chartScreen
              ExpenseChartScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
          backgroundColor: Color.fromARGB(255, 20, 104, 174),
          selectedIndex: bottomNavIndex,
          onItemSelected: (index) {
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.white54),
                ),
                icon: Icon(
                  Icons.home,
                  color: Colors.white54,
                )),
            BottomNavyBarItem(
                title: Text(
                  'History  ',
                  style: TextStyle(color: Colors.white54),
                ),
                icon: Icon(
                  Icons.history,
                  color: Colors.white54,
                )),
            BottomNavyBarItem(
                title: Text(
                  'Category  ',
                  style: TextStyle(color: Colors.white54),
                ),
                icon: Icon(
                  Icons.category,
                  color: Colors.white54,
                )),
            BottomNavyBarItem(
                title: Text(
                  'Chart ',
                  style: TextStyle(color: Colors.white54),
                ),
                icon: Icon(
                  Icons.moving,
                  color: Colors.white54,
                )),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          if (bottomNavIndex == 2 ||
              categoryDB.instance.listAllCategory.isEmpty) {
            showCategoryPopUp(context);
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => addTransactionScreen()));
          }
        }),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
//  Color.fromARGB(255, 51, 130, 194),
//                                     Color.fromARGB(255, 96, 195, 119),
