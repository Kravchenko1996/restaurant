import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data.dart';
import 'package:restaurant/model/menu.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/pages/home-page.dart';

class AddToOrderPage extends StatefulWidget {
  final Order selectedOrderDetails;

  AddToOrderPage({this.selectedOrderDetails});

  @override
  _AddToOrderPageState createState() => _AddToOrderPageState();
}

class _AddToOrderPageState extends State<AddToOrderPage> {
  List<SelectedDishe> selectedDishes = [];
  int totalCost = 0;

  final MenuList menuList = MenuList();

  @override
  void initState() {
    super.initState();
    getSelectedDishes(widget.selectedOrderDetails.id);
  }

  void getSelectedDishes(id) async {
    selectedDishes =
        await SelectedDishe().select().ordersId.equals(id).toList();
    selectedDishes.forEach((element) {
      totalCost += element.price;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, Data value, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.selectedOrderDetails.name} Order Details'),
          ),
          body: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                  child: Column(
                    children: [
                      ...menuList.menu
                          .map(
                            (value) => DishWidget(
                              name: value.name,
                              price: value.price,
                              selectedOrderDetails: widget.selectedOrderDetails,
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 500,
                      child: ListView.builder(
                        itemCount: value.getData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Text(
                                '${value.getData[index].name}',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      'Total cost: ${value.updateTotalCost()}',
                      style: TextStyle(fontSize: 24),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
                            },
                            color: Colors.redAccent,
                          ),
                          RaisedButton(
                            child: Text(
                              'Close order',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () async {
                              await Order()
                                  .select()
                                  .id
                                  .equals(widget.selectedOrderDetails.id)
                                  .update({'isActive': 0});
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(),
                                ),
                              );
                            },
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DishWidget extends StatefulWidget {
  final String name;
  final int price;
  final Order selectedOrderDetails;

  DishWidget({this.name, this.price, this.selectedOrderDetails});

  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<DishWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, Data value, Widget child) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          child: RaisedButton(
            color: Colors.indigo,
            child: Text(
              '${widget.name} - ${widget.price}',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            onPressed: () async {
              await SelectedDishe.withFields(widget.name, widget.price,
                      widget.selectedOrderDetails.id, false)
                  .save();
              value.updateSelectedDishes(
                SelectedDishe(
                  id: 0,
                  name: widget.name,
                  price: widget.price,
                  ordersId: widget.selectedOrderDetails.id,
                  isDeleted: false,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
