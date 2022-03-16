import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/utils/sql/db_helper.dart';
import 'package:carros/utils/sql/entity.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
abstract class BaseDAO<T extends Entity> {
  Future<Database?> get db => DatabaseHelper.getInstance().db;
  T fromJson(Map<String, dynamic> map);
  String get tableName;

  Future<int?> save(T? entity) async {
    var dbClient = await db;
    var id = await dbClient?.insert(tableName, entity!.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<T>?> query(String sql, [List<dynamic>? arguments]) async {
    final dbClient = await db;

    final list = await dbClient?.rawQuery(sql, arguments);

    final carros = list?.map<T>((json) => fromJson(json)).toList();

    return carros;
  }

  Future<List<T>?> findAll() {
    return query('select * from $tableName');
  }

  Future<T?> findById(int? id) async {
    List<T>? list = await query('select * from $tableName where id = ?', [id]);

    return list!.isNotEmpty ? list.first : null;
  }

  Future<bool> exists(int id) async {
    T? c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .rawDelete('delete from $tableName where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from $tableName');
  }
}
