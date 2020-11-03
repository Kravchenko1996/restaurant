import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

const tableOrders = SqfEntityTable(
    tableName: 'orders',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
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
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('price', DbType.integer),
      SqfEntityFieldRelationship(
          parentTable: tableOrders,
          deleteRule: DeleteRule.CASCADE,
          defaultValue: 0)
    ]);

const tableDesks = SqfEntityTable(
    tableName: 'desks',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_unique,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text),
    ]);

const tableDishes = SqfEntityTable(
    tableName: 'dishes',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_unique,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text),
      SqfEntityField('price', DbType.integer),
    ]);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: 'MyDbModel',
    databaseName: 'sampleORM.db',
    password: null,
    databaseTables: [
      tableOrders,
      tableSelectedDishes,
      tableDesks,
      tableDishes
      // tableTables,
      // tableDishes
    ],
    bundledDatabasePath: null);

// run every time after changes:
// flutter pub run build_runner build --delete-conflicting-outputs
