import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';

class Data with ChangeNotifier {
  List<SelectedDishe> _selectedDishes = [];
  List<Order> _activeOrders = [];

  List<SelectedDishe> get getDishes => _selectedDishes;
  List<Order> get getActiveOrders => _activeOrders;

  getActiveOrdersFromDB() async {
    _activeOrders =
        await Order().select().isActive.equals(true).toList();
    notifyListeners();
  }

  addActiveOrderToDB(value) async {
    _activeOrders.add(value);
  }

  getSelectedDishesById(id) async {
    _selectedDishes =
        await SelectedDishe().select().ordersId.equals(id).toList();
    notifyListeners();
  }

  int updateTotalCost() {
    int _totalCost = 0;
    _selectedDishes.forEach((element) {
      _totalCost += element.price;
    });
    return _totalCost;
  }
}
