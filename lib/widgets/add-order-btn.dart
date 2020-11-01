import 'package:flutter/material.dart';
import 'package:restaurant/database_helper.dart';
import 'package:restaurant/models/tables.dart';
import 'package:restaurant/pages/home-page.dart';

class AddOrderBtn extends StatefulWidget {
  @override
  _AddOrderBtnState createState() => _AddOrderBtnState();
}

class _AddOrderBtnState extends State<AddOrderBtn> {
  final TablesList tablesList = TablesList();

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
            content: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...tablesList.tables
                      .map(
                        (value) => TableWidget(name: value.name),
                      )
                      .toList(),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'))
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
        onPressed: () {
          DatabaseHelper.instance.insert({
            DatabaseHelper.columnName: widget.name,
            DatabaseHelper.columnSelectedDishes: '',
          });
          // print(widget.name);
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
