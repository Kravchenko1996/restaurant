import 'package:flutter/material.dart';
import 'package:restaurant/model/model.dart';

class Data with ChangeNotifier {
  List<SelectedDishe> _selectedDishes = [];

  List<SelectedDishe> get getData => _selectedDishes;

  void updateSelectedDishes(SelectedDishe item) {
    _selectedDishes.add(item);
    notifyListeners();
  }

  int updateTotalCost() {
    int totalCost = 0;
    _selectedDishes.forEach((element) {
      totalCost += element.price;
    });
    return totalCost;
  }
}