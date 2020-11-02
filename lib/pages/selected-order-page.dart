import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/pages/add-to-order-page.dart';
import 'package:restaurant/pages/home-page.dart';

class SelectedOrder extends StatefulWidget {
  final Order selectedOrder;

  SelectedOrder({this.selectedOrder});

  @override
  _SelectedOrderState createState() => _SelectedOrderState();
}

class _SelectedOrderState extends State<SelectedOrder> {
  void deleteOrder(id) async {
    await Order().select().id.equals(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedOrder.name} Order'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddToOrderPage(
                        selectedOrderDetails: widget.selectedOrder,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Add something to order',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  'Close the order',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Center(
                        child: Column(
                          children: [
                            Center(
                              child: Text('Are you sure '
                                  'you want to close '
                                  '${widget.selectedOrder.name} '
                                  'Order?'),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RaisedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('NO'),
                                  ),
                                  RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      setState(() {
                                        print(widget.selectedOrder);
                                        deleteOrder(widget.selectedOrder.id);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HomePage()),
                                        );
                                      });
                                    },
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
