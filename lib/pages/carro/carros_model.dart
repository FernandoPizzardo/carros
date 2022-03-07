import 'dart:async';

import 'package:carros/pages/carro/carros_api.dart';

import 'carro.dart';

import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<Carro>? carros;

  @observable
  Exception? error;

  @action
  fetch(tipo) async {
    try {
      carros = await CarrosApi.getCarros(tipo);
    } catch (e) {
      error = e as Exception?;
    }
  }
}
