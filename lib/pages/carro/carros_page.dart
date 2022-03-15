import 'dart:async';

import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/widgets/tetx_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/nav.dart';
import 'carro.dart';
import 'carro_page.dart';
import 'carros_api.dart';
import 'carros_model.dart';

class CarroPage extends StatelessWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(carro.nome.toString()),
        ),
        body: _body());
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Image.network(carro.urlFoto.toString()),
    );
  }
}
