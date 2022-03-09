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

class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  State<CarrosPage> createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
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

  Future<void>? _fetch() {
    _model.fetch(tipo);
  }

  late List<Carro> carros;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(
      builder: ((context) {
        carros = _model.carros!;
        if (_model.carros == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_model.error != null) {
          return TextError(
              "Erro ao carregar os carros\n\nClick para tentar novamente",
              onPressed: _fetch);
        } else {
          return RefreshIndicator(
            child: CarrosListView(carros),
            onRefresh: _onRefresh,
          );
        }
      }),
    );
  }

  Future<void> _onRefresh() {
    return _fetch()!;
  }
}
