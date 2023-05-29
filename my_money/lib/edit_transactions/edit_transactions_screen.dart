import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';
import 'package:my_money/DB_functions/transactions_db_functions/TransactionsDB.dart';
import 'package:my_money/home_screen/home_screen.dart';
import 'package:my_money/home_screen/recent_transactions.dart';
import 'package:my_money/models/category/category.dart';
import 'package:my_money/models/transactions/transaction_model.dart';

class editTransactionsScreen extends StatefulWidget {
  editTransactionsScreen(
      {Key? key,
      required this.transaction,
      required this.amount,
      required this.Notes,
      required this.type,
      required this.date,
      required this.category,
      required this.id})
      : super(key: key);
  final TransactionModel transaction;
  String amount;
  String Notes;
  CategoryType type;
  DateTime date;
  String category;
  dynamic id;

  @override
  State<editTransactionsScreen> createState() => _editTransactionsScreenState();
}

class _editTransactionsScreenState extends State<editTransactionsScreen> {
  CategoryType? _categoryType;
  DateTime? _dateTime;
  CategoryModel? _categoryModel;
  String? categoryID;
  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController _amountTextController = TextEditingController();
  categoryDB obj = categoryDB();

  @override
  void initState() {
    _amountTextController.text=widget.amount;
    _descriptionTextController.text=widget.Notes; 

   _dateTime=widget.date;
    _categoryType = widget.type;
    categoryDB.instance.refreshUI();
    categoryDB.instance.allCategoryListFunction();
       
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        toolbarHeight: 0.0,
      ),
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
            child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  'Edit Transactions', 
                  style: GoogleFonts.firaSans(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
                SizedBox(
                  height: 40,
                ),
                //amount
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromARGB(255, 116, 121, 172).withOpacity(0.2),
                  ),
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue.shade900,
                                ),
                                child: Icon(
                                  Icons.currency_rupee,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  child: TextFormField(
                                      controller: _amountTextController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600)),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      onChanged: ((value) {
                                        setState(() {});
                                      })))
                            ])),
                  ),
                ),
                //description

                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromARGB(255, 116, 121, 172).withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade900,
                          ),
                          child: Icon(
                            Icons.description,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextFormField(
                           
                            controller: _descriptionTextController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Notes ',
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600)),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            onChanged: ((value) {
                              setState(() {
                              widget.transaction.description=value;
                              widget.transaction.save(); 
                                
                              });
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Radio
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 12),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color:
                          Color.fromARGB(255, 116, 121, 172).withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade900,
                          ),
                          child: Icon(
                            Icons.check_box_outline_blank_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: Colors.blue.shade900,
                                value: CategoryType.income,
                                groupValue: _categoryType,
                                onChanged: ((value) {
                                  setState(() {
                                    _categoryType = CategoryType.income;
                                    categoryID = null;
                                    print(_categoryType);
                                  });
                                })),
                            const Text(
                              'Income',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: Colors.blue.shade900,
                                value: CategoryType.expense,
                                groupValue: _categoryType,
                                onChanged: ((value) {
                                  setState(() {
                                    _categoryType = CategoryType.expense;
                                    categoryID = null;
                                    print(_categoryType);
                                  });
                                })),
                            const Text(
                              'Expence ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // category list
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color.fromARGB(255, 116, 121, 172).withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade900,
                          ),
                          child: Icon(
                            Icons.category,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 0),
                          child: DropdownButton(
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down_sharp, size: 30),
                            hint: Text(
                              'Select Category ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(137, 70, 70, 70),
                                  fontWeight: FontWeight.bold),
                            ),
                            value: categoryID,
                            onChanged: ((newValue) {
                              
                              setState(() {
                                categoryID = newValue.toString();
                              });
                            }),
                            items: (_categoryType == CategoryType.income
                                    ? categoryDB().incomeCategoryListNotifier
                                    : categoryDB().expenseCategoryListNotifier)
                                .value
                                .map((e) {
                              return DropdownMenuItem(
                                onTap: (() {
                                  _categoryModel = e;
                                }),
                                child: Text(
                                  e.categoryName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800),
                                ),
                                value: e.id,
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // datePicker
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: (() {
                            datePicker();
                          }),
                          child: Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.blue.shade900,
                                size: 30,
                              ),
                              Text(
                                _dateTime == null
                                    ? 'Select Date'
                                    :  dateParse(_dateTime! ),
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel ')),
                    ),
                     Container(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue.shade900),
                          ),
                          onPressed: () {
                            validationOfAddTransactions(widget.id);

                       Navigator.of(context).pop();
                          },
                          child: Text('Submit')),
                    ), 
                  ],
                )
              ],
            )),
      ),
    );
  }

  Future<void> validationOfAddTransactions(id) async {
    // 1667236571685

    final _amountText = _amountTextController.text;
    final _descriptionText = _descriptionTextController.text;
    final _amountParced = double.tryParse(_amountText);
   if (_amountParced == null ||
        _descriptionText.isEmpty ||
        _dateTime == null ||
        _categoryModel == null ||
        _categoryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(255, 251, 29, 4),
          padding: EdgeInsets.all(10),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          width: 200,
          duration: Duration(
            seconds: 1,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill out all required fields.',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(255, 251, 29, 4),
          padding: EdgeInsets.all(10),
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          width: 200,
          duration: Duration(
            seconds: 3,
          ),
        ),
      );
    } else{
    final _transactionsSampleEdit = TransactionModel(
        amount: _amountParced,
        category: _categoryModel!,
        date: _dateTime!,
        description: _descriptionText,
        type: _categoryType!,id: id);
    TransactionsDB.instance
        .editTransactions(_transactionsSampleEdit, widget.id);
    TransactionsDB.instance.expenseTotalAmountFunction();
    TransactionsDB.instance.sumOfIncomeAmountFunction();
    TransactionsDB.instance.dateForChartFunction();

    setState(() {});
  }}

  datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2026))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }
}
