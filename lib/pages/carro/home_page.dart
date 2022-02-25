import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:flutter/material.dart';

import 'carro.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carros'),
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    List<Carro> carros = CarrosApi.getCarros();

    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (context, index) {
        Carro c = carros[index];
        return Column(children: [
          Image.network(
            c.urlFoto ?? '',
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text(
            c.nome ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]);
      },
    );
  }
}
