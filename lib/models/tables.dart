class Table {
  final String name;

  Table(this.name);
}

class TablesList {
  final tablesList = [
    Table('Table 1'),
    Table('Table 2'),
    Table('Table 3'),
    Table('Table 4'),
    Table('Table 5'),
    Table('Table 6'),
    Table('Table 7'),
    Table('Table 8'),
  ];
  List<Table> get tables => [...tablesList];
}
