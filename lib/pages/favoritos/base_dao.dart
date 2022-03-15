import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:carros/pages/favoritos/entity.dart';
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

  Future<List<T>?> findAll() async {
    final dbClient = await db;

    final list = await dbClient?.rawQuery('select * from carro');

    final carros = list?.map<T>((json) => fromJson(json)).toList();

    return carros;
  }

  Future<T> findById(int? id) async {
    var dbClient = await db;

    final list =
        await dbClient?.rawQuery('select * from carro where id = ?', [id]);

    if (list!.isNotEmpty) {
      return fromJson(list.first);
    }
    throw Exception("T não encontrado!");
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from carro');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from carro where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from carro');
  }
}
