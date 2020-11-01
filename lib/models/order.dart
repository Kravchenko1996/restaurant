import 'package:flutter/cupertino.dart';

class Order {
  int id;
  String name;
  List<String> selectedDishes;

  Order({@required this.id, @required this.name, this.selectedDishes});
}
