import 'package:restaurant/model/model.dart';

class MenuList {
  List<Dishe> menuList = [
    Dishe.withFields(1, 'Dish 1', 100),
    Dishe.withFields(2, 'Dish 2', 200),
    Dishe.withFields(3, 'Dish 3', 300),
    Dishe.withFields(4, 'Dish 4', 400),
    Dishe.withFields(5, 'Dish 5', 500),
    Dishe.withFields(6, 'Dish 6', 600),
    Dishe.withFields(7, 'Dish 7', 700),
    Dishe.withFields(8, 'Dish 8', 800),
  ];

  createDishes() async {
    await Dishe().upsertAll(menuList);
  }

  List<Dishe> get menu => [...menuList];
}
