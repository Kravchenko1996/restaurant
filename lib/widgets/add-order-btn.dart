import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/pages/add-to-order-page.dart';

class AddOrderBtn extends StatefulWidget {
  @override
  _AddOrderBtnState createState() => _AddOrderBtnState();
}

class _AddOrderBtnState extends State<AddOrderBtn> {
  List<Desk> tables = [];

  _AddOrderBtnState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Data>(context, listen: false).getActiveOrdersFromDB();
    });
  }

  @override
  void initState() {
    super.initState();
    getTables();
    setState(() {});
  }

  void getTables() async {
    tables = await Desk().select().toList();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 5,
      tooltip: 'Add new order',
      onPressed: () => {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Center(
              child: Text(
                'Choose the table:',
                style: TextStyle(fontSize: 28),
              ),
            ),
            content: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 300,
                      child: ListView.builder(
                          itemCount: tables.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Center(
                                child: TableWidget(name: tables[index].name),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      },
    );
  }
}

class TableWidget extends StatefulWidget {
  final String name;

  TableWidget({this.name});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 11;
    final double itemWidth = size.width;
    return Consumer(
      builder: (BuildContext context, Data value, Widget child) {
        return Container(
          width: itemWidth,
          height: itemHeight,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: RaisedButton(
            color: Colors.white,
            onPressed: () async {
              final result =
                  await Order.withFields(widget.name, true, 0, DateTime.now())
                      .save();
              var createdOrder =
                  await Order().select().id.equals(result.toString()).toList();
              value.addActiveOrderToDB(createdOrder.single);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddToOrderPage(
                    selectedOrder: createdOrder.single,
                  ),
                ),
              );
              Navigator.pop(context);
            },
            child: Text(
              widget.name,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
