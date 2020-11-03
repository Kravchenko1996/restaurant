import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/widgets/drawer.dart';

class AllOrdersPage extends StatefulWidget {
  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  List<Order> closedOrders = [];

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    closedOrders = await Order().select().isActive.equals(false).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('Closed Orders'),
        ),
      ),
      drawer: BurgerMenu(),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                if (index == closedOrders.length) return null;
                return Container(
                  alignment: Alignment.center,
                  color: Colors.indigo,
                  padding: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        '${closedOrders[index].name} Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
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
