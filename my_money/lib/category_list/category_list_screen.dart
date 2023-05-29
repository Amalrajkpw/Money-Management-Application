import 'package:flutter/material.dart';
import 'package:my_money/DB_functions/Category_db_functions/CategoryDB.dart';

import 'package:my_money/models/category/category.dart';
 
import 'package:my_money/widgets/animations.dart';

class tabBarWidget extends StatefulWidget {
  tabBarWidget({Key? key}) : super(key: key);

  @override
  State<tabBarWidget> createState() => _tabBarWidgetState();
}

class _tabBarWidgetState extends State<tabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    categoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: Color.fromARGB(255, 42, 127, 196).withOpacity(0.3)),
            child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 30, right: 30),
                unselectedLabelColor: Color.fromARGB(255, 119, 116, 116),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue.shade600,
                ),
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expense',
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              ValueListenableBuilder(
                valueListenable: categoryDB().incomeCategoryListNotifier,
                builder: (BuildContext context, List<CategoryModel> newList,
                    Widget? _) {
                  return newList.length == 0
                      ? Center(child: categoryNotFoundText())
                      : ListView.builder(
                          itemCount: newList.length,
                          itemBuilder: ((context, index) {
                            final categoryName = newList[index];
                            return Container(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 20, right: 50, top: 20),
                                padding: EdgeInsets.only(left: 20, top: 0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/category_container_img.png'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.dstATop),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromARGB(255, 196, 220, 239),
                                        Color.fromARGB(255, 42, 136, 209),
                                      ],
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      categoryName.categoryName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 251, 251, 252)
                                                .withOpacity(0.0),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                                backgroundColor: Color.fromARGB(
                                                    255, 149, 193, 234),
                                                title: Center(
                                                    child: Text(
                                                  "Delete  ?",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 6, 5, 5)),
                                                )),
                                                content: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      await categoryDB.instance
                                                          .allCategoryListFunction();
                                                      categoryDB.instance
                                                          .deleteCategory(
                                                              categoryName.id);
                                                      Navigator.pop(ctx);
                                                    },
                                                    child: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                },
              ),
              ValueListenableBuilder(
                valueListenable: categoryDB().expenseCategoryListNotifier,
                builder: (BuildContext context,
                    List<CategoryModel> newListExpense, Widget? _) {
                  return newListExpense.length == 0
                      ? Center(child: categoryNotFoundText())
                      : ListView.builder(
                          itemCount: newListExpense.length,
                          itemBuilder: ((context, index) {
                            final category = newListExpense[index];
                            return Container(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: 20, right: 50, top: 20),
                                padding: EdgeInsets.only(left: 20, top: 0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'images/category_container_img.png'),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.6),
                                          BlendMode.dstATop),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromARGB(255, 196, 220, 239),
                                        Color.fromARGB(255, 42, 136, 209),
                                      ],
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category.categoryName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 251, 251, 252)
                                                .withOpacity(0.0),
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext ctx) {
                                            return AlertDialog(
                                                backgroundColor: Color.fromARGB(
                                                    255, 149, 193, 234),
                                                title: Center(
                                                    child: Text(
                                                  "Delete  ?",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 6, 5, 5)),
                                                )),
                                                content: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Colors.red ,
                                                    ),
                                                    onPressed: () {
                                                      categoryDB.instance
                                                          .deleteCategory(
                                                              category.id);
                                                      Navigator.pop(ctx);
                                                    },
                                                    child: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )));
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }));
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
