class Dish {
  final String name;

  Dish(this.name);
}

class MenuList {
  final menuList = [
    Dish('Sample Dish 1'),
    Dish('Sample Dish 2'),
    Dish('Sample Dish 3'),
    Dish('Sample Dish 4'),
    Dish('Sample Dish 5'),
    Dish('Sample Dish 6'),
    Dish('Sample Dish 7'),
    Dish('Sample Dish 8'),
  ];

  List<Dish> get menu => [...menuList];
}
