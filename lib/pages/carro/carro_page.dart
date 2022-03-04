import 'dart:ui';

import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  Carro? carro;
  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro!.nome.toString()),
      ),
      body: _body(),
    );
  }

  _body() {
    return Image.network(
        "https://assets.whichcar.com.au/image/private/s--BUSGJnJf--/ar_2.304921968787515,c_fill,f_auto,g_xy_center,q_auto:good,x_600,y_450/v1/Street%20Machine/News/2022_Batmobile_The_Batman_3.jpg");
  }
}
