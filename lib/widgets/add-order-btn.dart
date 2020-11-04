import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/pages/home-page.dart';

class AddOrderBtn extends StatefulWidget {
  @override
  _AddOrderBtnState createState() => _AddOrderBtnState();
}

class _AddOrderBtnState extends State<AddOrderBtn> {
  List<Desk> tables = [];

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
                'Choose the table',
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
                child: Text('Close'),
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
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextButton(
        onPressed: () async {
          await Order.withFields(widget.name, true, 0, DateTime.now()).save();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
          );
        },
        child: Text(
          widget.name,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
