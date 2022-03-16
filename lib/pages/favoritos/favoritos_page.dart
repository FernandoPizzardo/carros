import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/widgets/tetx_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/nav.dart';
import '../carro/carro.dart';
import '../carro/carro_page.dart';
import '../carro/carros_bloc.dart';
import '../carro/carros_listview.dart';
import 'favoritos_bloc.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  List<Carro>? carros;

  final _bloc = FavoritosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro>? carros = snapshot.data as List<Carro>?;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: _listView(carros),
        );
      },
    );
  }

  _listView(List<Carro>? carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros!.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: c.urlFoto ??
                          "https://static.wikia.nocookie.net/liberproeliis/images/3/3f/Dilay-Shrek_%288%29.png/revision/latest?cb=20200415013959&path-prefix=pt-br",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonTheme(
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        TextButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        TextButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }
}
