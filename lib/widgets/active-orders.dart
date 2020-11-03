import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/pages/selected-order-page.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List<Order> activeOrders = [];

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    activeOrders = await Order().select().isActive.equals(true).toList();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == activeOrders.length) return null;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectedOrder(
                    selectedOrder: activeOrders[index],
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
