import 'package:flutter/material.dart';
import 'package:restaurant/models/order.dart';

import '../database_helper.dart';

// class ActiveOrders extends StatefulWidget {
//   @override
//   _ActiveOrdersState createState() => _ActiveOrdersState();
// }
//
// class _ActiveOrdersState extends State<ActiveOrders> {
//   final ActiveOrdersList activeOrders = ActiveOrdersList();
//
//   @override
//   Widget build(BuildContext context) {
//     // return ListView(
//     //   children: [
//     //     Container(
//     //       child: Column(
//     //         children: [
//     //            ...activeOrders.orders.map(
//     //                (value) => ActiveOrderWidget(name: value.name)
//     //            ).toList(),
//     //         ],
//     //       ),
//     //     ),
//     //   ],
//     // );
//     return ListView.builder(
//         itemCount: activeOrders.orders.length,
//         itemBuilder: (BuildContext context, int index) {
//       return Container(
//         child: Column(
//           children: [
//             ActiveOrderWidget(name: activeOrders.orders[index].name)
//           ],
//         ),
//       );
//     });
//   }
// }
//
// class ActiveOrderWidget extends StatefulWidget {
//   final String name;
//
//   ActiveOrderWidget({this.name});
//
//   @override
//   _ActiveOrderWidgetState createState() => _ActiveOrderWidgetState();
// }
//
// class _ActiveOrderWidgetState extends State<ActiveOrderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       color: Colors.indigo,
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: Text(
//         widget.name,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 24,
//         ),
//       ),
//     );
//   }
// }

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List<Order> activeOrders = [];

  @override
  void initState() {
    super.initState();

    DatabaseHelper.instance.queryAllRows().then(
          (value) => setState(() {
            value.forEach((element) {
              activeOrders.add(
                Order(name: element['name']),
              );
            });
          }),
        );
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == activeOrders.length) return null;
          return Container(
            alignment: Alignment.center,
            color: Colors.indigo,
            padding: const EdgeInsets.only(top: 10),
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
          );
        },
      ),
    );
  }
}

// FlatButton(
// onPressed: () async {
// List<Map<String, dynamic>> queryRows = await DatabaseHelper
//     .instance.queryAllRows();
// print(queryRows);
// },
// child: Text('GET'),
// );
