class Dish {
  final String name;
  final int price;

  Dish(this.name, this.price);
}

class MenuList {
  final menuList = [
    Dish('Sample Dish 1', 100),
    Dish('Sample Dish 2', 200),
    Dish('Sample Dish 3', 300),
    Dish('Sample Dish 4', 400),
    Dish('Sample Dish 5', 500),
    Dish('Sample Dish 6', 600),
    Dish('Sample Dish 7', 700),
    Dish('Sample Dish 8', 800),
  ];

  List<Dish> get menu => [...menuList];
}
