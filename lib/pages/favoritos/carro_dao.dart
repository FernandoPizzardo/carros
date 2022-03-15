import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/favoritos/base_dao.dart';
import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  fromJson(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  Future<List<Carro>?> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list =
        await dbClient?.rawQuery('select * from carro where tipo =? ', [tipo]);

    final carros = list?.map<Carro>((json) => fromJson(json)).toList();

    return carros;
  }
}
