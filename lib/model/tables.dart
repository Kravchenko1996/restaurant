import 'package:restaurant/model/model.dart';

class TablesList {
  List<Desk> tablesList = [
    Desk.withFields(1, 'Table 1'),
    Desk.withFields(2, 'Table 2'),
    Desk.withFields(3, 'Table 3'),
    Desk.withFields(4, 'Table 4'),
    Desk.withFields(6, 'Table 6'),
    Desk.withFields(5, 'Table 5'),
    Desk.withFields(7, 'Table 7'),
    Desk.withFields(8, 'Table 8'),
  ];

  createTables() async {
    await Desk().upsertAll(tablesList);
  }

  List<Desk> get tables => [...tablesList];
}
