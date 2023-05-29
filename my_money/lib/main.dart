import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
 
import 'package:my_money/login/login_screen.dart';

import 'package:my_money/models/category/category.dart';
import 'package:my_money/models/transactions/transaction_model.dart';
import 'package:my_money/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CategoryTypeAdapter());

  Hive.registerAdapter(CategoryModelAdapter());

  Hive.registerAdapter(TransactionModelAdapter());

  runApp(MoneyManagementApp());
}

class MoneyManagementApp extends StatelessWidget {
  const MoneyManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: splashScreen());
  }
} 