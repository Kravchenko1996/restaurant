import 'package:flutter/material.dart';
import 'package:restaurant/models/order.dart';
import 'file:///C:/Users/User/AndroidStudioProjects/restaurant/lib/pages/selected-order-page.dart';

import '../database_helper.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List<Order> activeOrders = [];

  @override
  void initState() {
    DatabaseHelper.instance.queryAllRows().then(
          (value) => setState(() {
            value.forEach((element) {
              activeOrders.add(
                Order(id: element['id'], name: element['name']),
              );
            });
          }),
        );
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == activeOrders.length) return null;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectedOrder(
                    selectedOrder: Order(
                        id: activeOrders[index].id,
                        name: activeOrders[index].name),
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              color: Colors.indigo,
              padding: const EdgeInsets.only(top: 8),
              child: ListTile(
                title: Center(
                  child: Text(
                    '${activeOrders[index].name} Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
