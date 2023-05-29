import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';
import 'package:my_money/const.dart';
import 'package:my_money/login/login_screen.dart';
import 'package:my_money/home_screen/home_screen.dart';

import 'package:my_money/splash_screen/my_money_heading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/animations.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  @override
  void initState() {
    TransactionsDB obj = TransactionsDB();
    categoryDB category = categoryDB();
    obj.expenseTotalAmountFunction();
    obj.sumOfIncomeAmountFunction();
    obj.dateForChartFunction();
    obj.refreshUIFullList();
    obj.searchListFunction();
    category.allCategoryListFunction();
    super.initState();
    Timer(Duration(seconds: 2), () => checkLoggedIn());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 233, 238, 242),
            Color.fromARGB(255, 108, 182, 238),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const myMoneyHeading(),
            Container(
              height: 300,
              width: double.infinity,
              child: Lottie.asset('animations/loading.json',
                  height: 200, repeat: true, fit: BoxFit.fill),
            ),
            const InitialisingText(),
          ],
        ),
      )),
    );
  }

  Future<void> checkLoggedIn() async {
    final sharedPref = await SharedPreferences.getInstance();
    final _userLoggedIn = sharedPref.getBool(SAVE_KEY);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenGetStarted()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => homeScreen()));
    }
  }
}
