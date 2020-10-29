import 'package:flutter/material.dart';
import 'package:restaurant/widgets/active-orders.dart';
import 'package:restaurant/widgets/add-order-btn.dart';
import 'package:restaurant/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('Active Orders'),
        ),
      ),
      drawer: BurgerMenu(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ActiveOrders(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please select an order to check the information',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AddOrderBtn(),
    );
  }
}
