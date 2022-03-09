import 'dart:async';

import 'package:carros/widgets/tetx_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/nav.dart';
import 'carro.dart';
import 'carro_page.dart';
import 'carros_api.dart';
import 'carros_model.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  State<CarrosListView> createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  final _streamController = StreamController<List<Carro>>();
  @override
  bool get wantKeepAlive => true;
  _loadData() async {
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);
    _streamController.add(carros);
  }

  String get tipo => widget.tipo;

  final _model = CarrosModel();

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  void _fetch() {
    _model.fetch(tipo);
  }

  late List<Carro>? carros;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(
      builder: ((context) {
        carros = _model.carros;
        if (_model.carros == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_model.error != null) {
          return TextError(
              "Erro ao carregar os carros\n\nClick para tentar novamente",
              onPressed: _fetch);
        } else {
          return _listView(carros);
        }
      }),
    );
  }
}

_listView(List<Carro>? carros) {
  return ListView.builder(
      itemCount: carros!.length,
      itemBuilder: (context, index) {
        Carro c = carros[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    c.urlFoto ?? '',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  c.nome ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Detalhes'),
                  onPressed: () => _onClickCarro(c, context),
                ),
                const SizedBox(width: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: const Text('Share'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        );
      });
}

_onClickCarro(Carro c, context) {
  push(context, CarroPage(c));
}
