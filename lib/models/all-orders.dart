class Order {
  final String name;

  Order(this.name);
}

class AllOrdersList {
  final allOrdersList = [
    Order('Table 1 Order'),
    Order('Table 1 Order 2'),
    Order('Table 2 Order'),
    Order('Table 3 Order'),
    Order('Table 4 Order'),
    Order('Table 5 Order'),
    Order('Table 6 Order'),
  ];

  List<Order> get orders => [...allOrdersList];
}
