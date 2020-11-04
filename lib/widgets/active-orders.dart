import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data.dart';
import 'package:restaurant/pages/add-to-order-page.dart';

class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {

  @override
  void initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.5;
    final double itemWidth = size.width / 2;

    return Consumer(builder: (BuildContext context, Data value, Widget child) {
      return Container(
        child: GridView.builder(
          itemCount: value.getActiveOrders.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddToOrderPage(
                      selectedOrder: value.getActiveOrders[index],
                    ),
                  ),
                );
              },
              child: GridTile(
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    border: Border.all(
                      width: 2,
                      color: Colors.indigo,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${value.getActiveOrders[index].name}',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
