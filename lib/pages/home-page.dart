import 'package:flutter/material.dart';
import 'package:restaurant/widgets/active-orders.dart';
import 'package:restaurant/widgets/add-order-btn.dart';
import 'package:restaurant/widgets/drawer.dart';

class HomePage extends StatelessWidget {
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
