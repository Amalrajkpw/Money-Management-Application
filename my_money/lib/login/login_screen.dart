import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/const.dart';
import 'package:my_money/home_screen/home_screen.dart';
import 'package:my_money/models/category/category.dart';
 
import 'package:my_money/splash_screen/my_money_heading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenGetStarted extends StatefulWidget {
  
  ScreenGetStarted({Key? key}) : super(key: key);

  @override
  State<ScreenGetStarted> createState() => _ScreenGetStartedState();
}


class _ScreenGetStartedState extends State<ScreenGetStarted> {
  final form_key_getStarted = GlobalKey<FormState>();

  @override
  void initState() {
 addDefaultCategoryList();

    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 228, 233, 236),
            Color.fromARGB(255, 95, 168, 223),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                myMoneyHeading(),
                SizedBox(
                  height: 20,
                ),
                Lottie.asset(
                  'animations/coin_animation.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                )
              ],
            ),
            Column(
              children: [
                Form(
                  key: form_key_getStarted,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Enter Mobile No',
                          hintText: 'Enter Mobile',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade700, fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.blue.shade100),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'Incorrect Number';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      validationOfPhoneNumber();
                    },
                    child: Text('Get Started ')),
              ],
            ),
            Text(
              'We allow you to track your spending and\nmanage your cash flow on daily basis.\nHelping you to move closer to your\nfinancial goals',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal, color: Colors.grey.shade300),
            )
          ],
        ),
      )),
    );
  }

  void validationOfPhoneNumber() async {
    if (form_key_getStarted.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Loading...',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue.shade300,
          padding: EdgeInsets.all(10),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          width: 200,
          duration: Duration(
            seconds: 1,
          ),
        ),
      );
      final _sharedPref = await SharedPreferences.getInstance();
      await _sharedPref.setBool(SAVE_KEY, true);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homeScreen()));
    }
  }
  addDefaultCategoryList(){
        final salaryCategory=CategoryModel(categoryName:'Salary',type: CategoryType.income, id:   'id');
  categoryDB.instance.insertCategory(salaryCategory);
   categoryDB.instance.refreshUI();
  
  final food=CategoryModel(categoryName: 'Food',type: CategoryType.expense,id: DateTime.now().millisecondsSinceEpoch.toString());
  categoryDB.instance.insertCategory(food);

  categoryDB.instance.refreshUI();
 
  }
}
