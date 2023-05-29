import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseChartScreen extends StatefulWidget {
  ExpenseChartScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseChartScreen> createState() => _ExpenseChartScreenState();
}

class _ExpenseChartScreenState extends State<ExpenseChartScreen> {
  TooltipBehavior? _tooltipBehavior;
  TransactionsDB obj = TransactionsDB();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/category_background.jpeg'),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 108, 182, 238),
                        Color.fromARGB(255, 108, 182, 238),
                      ],
                    )),
                child: Container(
                    margin: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Expanded(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // Chart title
                              title: ChartTitle(
                                  text: ' Expense Chart',
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  )),
                              // Enable legend
                              legend: Legend(isVisible: false),
                              // Enable tooltip
                              tooltipBehavior: _tooltipBehavior,
                              series: <LineSeries<ExpenseData, String>>[
                                LineSeries<ExpenseData, String>(
                                    dataSource: <ExpenseData>[
                                      for (int i = 0;
                                          i < obj.listExpenseAmount.length;
                                          i++)
                                        ExpenseData(
                                            obj.listExpenseAmount[i] as double,
                                            obj.listDate[i]),
                                    ],
                                    xValueMapper: (ExpenseData Date, _) =>
                                        dateParse(Date.date),
                                    yValueMapper: (ExpenseData Expense, _) =>
                                        Expense.amount as double,
                                    // Enable data label
                                    dataLabelSettings: DataLabelSettings(
                                        isVisible: true, color: Colors.blue))
                              ]),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )))));
  }

  String dateParse(DateTime dateTime) {
    final _date = DateFormat.MMMd().format(dateTime);
    final _splittedDate = _date.split('  ');
    return '${_splittedDate.last}';
  }
}

class ExpenseData {
  ExpenseData(this.amount, this.date);

  final double amount;
  final DateTime date;
}
