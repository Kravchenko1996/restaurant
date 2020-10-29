import 'package:flutter/material.dart';
import 'package:restaurant/models/menu.dart';
import 'package:restaurant/models/order.dart';

class AddToOrderPage extends StatefulWidget {
  final Order selectedOrderDetails;

  AddToOrderPage({this.selectedOrderDetails});

  @override
  _AddToOrderPageState createState() => _AddToOrderPageState();
}

class _AddToOrderPageState extends State<AddToOrderPage> {
  List<String> selectedDishes = [];
  final MenuList menuList = MenuList();

  void addItemToList(String item) {
    setState(() {
      selectedDishes.add(item);
    });
  }

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

              // THIS WORKS !!!

              // child: Column(
              //   children: [
              //     RaisedButton(
              //       onPressed: () {
              //         addItemToList('Sample dish 1');
              //       },
              //       child: Text('Sample dish 1'),
              //     ),
              //     RaisedButton(
              //       onPressed: () {
              //         addItemToList('Sample dish 2');
              //       },
              //       child: Text('Sample dish 2'),
              //     ),
              //     RaisedButton(
              //       onPressed: () {
              //         addItemToList('Sample dish 3');
              //       },
              //       child: Text('Sample dish 3'),
              //     ),
              //   ],
              // ),

              child: Column(
                children: [
                  ...menuList.menu
                      .map(
                        (value) => DishWidget(
                          name: value.name,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: selectedDishes.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                    child: Text('${selectedDishes[index]}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DishWidget extends StatefulWidget {
  final String name;


  DishWidget({this.name});

  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<DishWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text(widget.name),
        onPressed: () {
        },
      ),
    );
  }
}
