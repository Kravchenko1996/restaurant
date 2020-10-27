import 'package:flutter/material.dart';
import 'package:restaurant/widgets/drawer.dart';

class AllOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('All Orders'),
        ),
      ),
      drawer: BurgerMenu(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('123'),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Please select an order to check the information',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
