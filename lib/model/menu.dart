import 'package:restaurant/model/model.dart';

class MenuList {
  List<Dishe> menuList = [];

  createDishes() async {
    await Dishe.withFields(1, 'Dish 1', 100).save();
    await Dishe.withFields(2, 'Dish 2', 200).save();
    await Dishe.withFields(3, 'Dish 3', 300).save();
    await Dishe.withFields(4, 'Dish 4', 400).save();
    await Dishe.withFields(5, 'Dish 5', 500).save();
    await Dishe.withFields(6, 'Dish 6', 600).save();
    await Dishe.withFields(7, 'Dish 7', 700).save();
    await Dishe.withFields(8, 'Dish 8', 800).save();
  }

  List<Dishe> get menu => [...menuList];
}
