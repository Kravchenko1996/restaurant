import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';

class SelectedClosedOrder extends StatefulWidget {
  final Order selectedClosedOrder;

  SelectedClosedOrder({this.selectedClosedOrder});

  @override
  _SelectedClosedOrderState createState() => _SelectedClosedOrderState();
}

class _SelectedClosedOrderState extends State<SelectedClosedOrder> {
  List<SelectedDishe> selectedDishes = [];

  @override
  void initState() {
    super.initState();
    getSelectedDishesById(widget.selectedClosedOrder.id);
  }

  getSelectedDishesById(id) async {
    selectedDishes =
        await SelectedDishe().select().ordersId.equals(id).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedClosedOrder.name} Order '
            '${widget.selectedClosedOrder.dateTime}'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: selectedDishes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            '${selectedDishes[index].name} - ${selectedDishes[index].price}',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
