import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';
import 'package:my_money/home_screen/home_screen.dart';
import 'package:my_money/models/category/category.dart';
import 'package:my_money/models/transactions/transaction_model.dart';
 
import 'package:my_money/transactions_detail_page/transaction_detail_page.dart';
import 'package:my_money/widgets/animations.dart';

import '../edit_transactions/edit_transactions_screen.dart';

class recentTransactions extends StatefulWidget {
  recentTransactions({Key? key}) : super(key: key);

  @override
  State<recentTransactions> createState() => _recentTransactionsState();
}

class _recentTransactionsState extends State<recentTransactions> {
  @override
  Widget build(BuildContext context) {
    TransactionsDB.instance.refreshUIFullList();
    TransactionsDB.instance.refreshUIseparatedList();
    
    return ValueListenableBuilder(
        valueListenable: TransactionsDB.instance.allTransactionListener,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return newList.length == 0
              ? Center(child: SizedBox())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: newList.length > 4 ? 4 : newList.length,
                  itemBuilder: (context, index) {
                    final transaction = newList[index];

                    return  
                        Padding(
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
                                    Color.fromARGB(255, 164, 239, 182),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16)),
                            child: ListTile(
                              onTap: (() {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return transactionsDetails(
                                      transaction: transaction);
                                }));
                              }),
                              leading: Container(
                                height: 20,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: transaction.type == CategoryType.income
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
                                transaction.category.categoryName,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Container(
                                child: Text(
                                  dateParse(transaction.date),
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ),
                              trailing: Wrap(
                                spacing: 12, // space between two icons
                                children: <Widget>[
                                  Icon(Icons.currency_rupee),
                                  Text(
                                    transaction.amount.toString(),
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
                      );
                    
                  });
        });
  }
}

String dateParse(DateTime dateTime) {
  final _date = DateFormat.MMMEd().format(dateTime);
  final _splittedDate = _date.split('  ');
  return '${_splittedDate.last}';
}
