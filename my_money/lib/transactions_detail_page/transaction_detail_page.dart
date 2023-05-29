import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:my_money/models/category/category.dart';
import 'package:my_money/models/transactions/transaction_model.dart';

class transactionsDetails extends StatelessWidget {
  transactionsDetails({Key? key, required this.transaction}) : super(key: key);
  TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 98, 101, 104),
            Color.fromARGB(255, 12, 12, 13),
          ],
        )),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromARGB(255, 8, 7, 7).withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 8, 7, 7).withOpacity(0.2),

                  spreadRadius: 4,
                  blurRadius: 17,
                  offset: Offset(0, 3), //
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              height: 500,
              width: double.infinity,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.note),
                    SizedBox(
                      width: 0,
                    ),
                    Text(
                      'Transaction Details',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount :',
                      style: GoogleFonts.secularOne(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 8, 6, 6),
                      ),
                    ),
                    Container(
                      child: Row(children: [
                        Icon(Icons.currency_rupee),
                        Text(transaction.amount.toString(),
                            style: GoogleFonts.secularOne(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ))
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Note :                                     ',
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(transaction.description,
                            style: GoogleFonts.secularOne(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Category Type :',
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                    Text(transaction.category.categoryName,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        softWrap: false,
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Method :',
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                    Text('Cash',
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transaction Type :',
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                    transaction.type == CategoryType.income
                        ? Text('Income',
                            style: GoogleFonts.secularOne(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ))
                        : Text('Expense',
                            style: GoogleFonts.secularOne(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date :',
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        )),
                    Text(dateParse(transaction.date),
                        style: GoogleFonts.secularOne(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary:
                            Color.fromARGB(255, 25, 24, 24).withOpacity(0.3),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Go Back',
                        style:
                            TextStyle(color: Color.fromARGB(255, 95, 92, 92)),
                      )),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  String dateParse(DateTime dateTime) {
    final _date = DateFormat.MMMEd().format(dateTime);
    final _splittedDate = _date.split('  ');
    return '${_splittedDate.last}';
  }
}
