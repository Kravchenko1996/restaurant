import 'package:flutter/material.dart';
import 'package:restaurant/models/menu.dart';
import 'package:restaurant/models/order.dart';
import 'package:restaurant/pages/home-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddToOrderPage extends StatefulWidget {
  final Order selectedOrderDetails;

  AddToOrderPage({this.selectedOrderDetails});

  @override
  _AddToOrderPageState createState() => _AddToOrderPageState();
}

class _AddToOrderPageState extends State<AddToOrderPage> {
  List<String> selectedDishes = [];

  // List<AddedDish> selectedDishesFromDB = [];

  final MenuList menuList = MenuList();

  void addItemToList(String item) {
    setState(() {
      selectedDishes.add(item);
      // addItemsToDB();
      addListToSP('selectedDishes', selectedDishes);
    });
  }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getListFromSP('selectedDishes');
  // }

  getListFromSP(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    selectedDishes = preferences.getStringList(key);
    return selectedDishes;
  }

  addListToSP(key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList(key, value);
  }

  addIntToSP(key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(key, value);
  }

  // void addItemsToDB() {
  //   DatabaseHelper.instance.update({
  //     DatabaseHelper.columnId: widget.selectedOrderDetails.id,
  //     DatabaseHelper.columnSelectedDishes: selectedDishes.toString()
  //   });
  // }

  // @override
  // void initState() {
  //   setState(() {
  //     var a = getItemsFromDB(widget.selectedOrderDetails.id);
  //     print(a);
  //   });
  //   super.initState();
  // }

  // getItemsFromDB(id) {
  //   var db = DatabaseHelper.instance
  //       .queryRowById(id)
  //       .then((value) => value.forEach((element) {
  //             print(element);
  //             selectedDishesFromDB.add(
  //               AddedDish(
  //                 name: element['selectedDishes'],
  //               ),
  //             );
  //           }));
  //   print(db);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedOrderDetails.name} Order Details'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              child: Column(
                children: [
                  ...menuList.menu
                      .map(
                        (value) => DishWidget(
                          name: value.name,
                          addItemToList: addItemToList,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // selectedDishesFromDB.length < selectedDishes.length
                Container(
                  height: 400,
                  child: ListView.builder(
                    itemCount: selectedDishes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            '${selectedDishes[index]}',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // : Container(
                //     height: 400,
                //     child: ListView.builder(
                //       itemCount: selectedDishesFromDB.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return Container(
                //           padding: EdgeInsets.only(top: 10),
                //           child: Center(
                //             child: Text(
                //               '${selectedDishesFromDB[index].name}',
                //               style: TextStyle(
                //                 fontSize: 24,
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                Text(
                  'Total cost: ',
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(),
                            ),
                          );
                        },
                        color: Colors.redAccent,
                      ),
                      RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          // DatabaseHelper.instance.insert({
                          //   DatabaseHelper.columnSelectedDishes:
                          //       selectedDishes.toString()
                          // });
                        },
                        color: Colors.indigo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DishWidget extends StatefulWidget {
  final String name;
  final addItemToList;

  DishWidget({this.name, this.addItemToList});

  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<DishWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: RaisedButton(
        color: Colors.indigo,
        child: Text(
          widget.name,
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        onPressed: () {
          widget.addItemToList(widget.name.toString());
        },
      ),
    );
  }
}
