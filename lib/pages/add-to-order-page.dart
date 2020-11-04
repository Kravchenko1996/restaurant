import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data.dart';
import 'package:restaurant/model/model.dart';
import 'package:restaurant/pages/home-page.dart';

class AddToOrderPage extends StatefulWidget {
  final Order selectedOrder;

  AddToOrderPage({this.selectedOrder});

  @override
  _AddToOrderPageState createState() => _AddToOrderPageState();
}

class _AddToOrderPageState extends State<AddToOrderPage> {
  List<Dishe> dishes = [];

  _AddToOrderPageState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Data>(context, listen: false)
          .getSelectedDishesById(widget.selectedOrder.id);
    });
  }

  @override
  void initState() {
    super.initState();
    getDishes();
  }

  getDishes() async {
    dishes = await Dishe().select().toList();
    setState(() {});
  }

  void deleteOrder(id) async {
    await Order()
        .select()
        .id
        .equals(id)
        .delete();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double selectedDishHeight = (size.height - kToolbarHeight - 24) / 11;
    final double selectedDishWidth = size.width / 3;
    final double btnHeight = (size.height - kToolbarHeight - 24) / 10;
    final double btnWidth = size.width / 5;

    return Consumer(
      builder: (BuildContext context, Data value, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${widget.selectedOrder.name} Order'),
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
                      Container(
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: dishes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: DishWidget(
                                        name: dishes[index].name,
                                        price: dishes[index].price,
                                        selectedOrderDetails:
                                        widget.selectedOrder),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: value.getDishes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Center(
                                child: Container(
                                  width: selectedDishWidth,
                                  height: selectedDishHeight,
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
                                      '${value.getDishes[index].name} - '
                                          '${value.getDishes[index].price}',
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 30),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              'Total cost: ${value.updateTotalCost()}',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: btnWidth,
                                height: btnHeight,
                                child: RaisedButton(
                                  color: Colors.redAccent,
                                  child: Text(
                                    'Delete the order',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) =>
                                          AlertDialog(
                                            title: Center(
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Text('Are you sure '
                                                        'you want to delete '
                                                        '${widget.selectedOrder
                                                        .name} '
                                                        'Order?'),
                                                  ),
                                                  Container(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        RaisedButton(
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                  context)
                                                                  .pop(),
                                                          child: Text('NO'),
                                                        ),
                                                        RaisedButton(
                                                          color: Colors
                                                              .redAccent,
                                                          onPressed: () {
                                                            setState(() {
                                                              deleteOrder(widget
                                                                  .selectedOrder
                                                                  .id);
                                                            });
                                                          },
                                                          child: Text(
                                                            'YES',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white,
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
                              ),
                              Container(
                                width: btnWidth,
                                height: btnHeight,
                                child: RaisedButton(
                                  child: Text(
                                    'Close the order',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    final result = await Order()
                                        .select()
                                        .id
                                        .equals(widget.selectedOrder.id)
                                        .update({'isActive': 0});
                                    print(result.toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => HomePage(),
                                      ),
                                    );
                                  },
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
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
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 9;
    final double itemWidth = size.width / 3;
    return Consumer(
      builder: (BuildContext context, Data value, Widget child) {
        return Container(
          height: itemHeight,
          width: itemWidth,
          padding: EdgeInsets.only(top: 10),
          child: RaisedButton(
            color: Colors.white,
            child: Text(
              '${widget.name} - ${widget.price}',
              style: TextStyle(fontSize: 22),
            ),
            onPressed: () async {
              await SelectedDishe.withFields(
                  widget.name, widget.price, widget.selectedOrderDetails.id)
                  .save();
              value.getSelectedDishesById(widget.selectedOrderDetails.id);
            },
          ),
        );
      },
    );
  }
}
