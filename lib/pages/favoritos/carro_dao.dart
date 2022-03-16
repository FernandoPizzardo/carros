import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/utils/sql/base_dao.dart';
import 'package:carros/utils/sql/db_helper.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  fromJson(Map<String, dynamic> map) {
    return Carro.fromJson(map);
  }

  Future<List<Carro>?> findAllByTipo(String tipo) {
    return query('select * from carro where tipo =? ', [tipo]);
  }
}
