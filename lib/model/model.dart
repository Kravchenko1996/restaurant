import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';

part 'model.g.dart';

const tableOrders = SqfEntityTable(
    tableName: 'orders',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('isActive', DbType.bool, defaultValue: true),
      SqfEntityField('totalCost', DbType.integer, defaultValue: 0)
    ]);

const tableSelectedDishes = SqfEntityTable(
    tableName: 'selectedDishes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: true,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('price', DbType.integer),
      SqfEntityFieldRelationship(
          parentTable: tableOrders,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0)
    ]);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel',
    databaseName: 'sampleORM.db',
    password: null,
    databaseTables: [tableOrders, tableSelectedDishes],
    bundledDatabasePath: null);

// run every time after changes:
// flutter pub run build_runner build --delete-conflicting-outputs
