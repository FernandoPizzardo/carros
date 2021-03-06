import 'dart:html';
import 'dart:ui';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro? carro;
  CarroPage(this.carro);

  @override
  State<CarroPage> createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();
  @override
  void initState() {
    super.initState();

    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro!.nome.toString()),
        actions: [
          // actions = botões na parte direita
          IconButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              _onClickMapa;
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              _onClickVideo;
            },
          ),
          PopupMenuButton(
              onSelected: (value) => _onClickPopupMenu,
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text("Editar"),
                    value: "Editar",
                  ),
                  const PopupMenuItem(
                    child: Text("Deletar"),
                    value: "Deletar",
                  ),
                ];
              })
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: ListView(children: <Widget>[
        Image.network(
          widget.carro!.urlFoto ??
              "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
        ),
        _primeiroBloco(),
        _segundoBloco(),
        _descricao()
      ]),
    );
  }

  Row _segundoBloco() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.favorite),
          color: Colors.red,
          onPressed: () {},
        ),
        text(
          "Favorito",
          fontSize: 20,
          bold: true,
        ),
        IconButton(
          icon: const Icon(Icons.share),
          color: Colors.blue,
          onPressed: () {},
        ),
        text(
          "Compartilhar",
          color: Colors.blueGrey,
        ),
      ],
    );
  }

  Row _primeiroBloco() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.carro!.nome.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.carro!.tipo.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  _descricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        text(
          widget.carro!.descricao.toString(),
          fontSize: 16,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return text(snapshot.data.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }
}

void _onClickPopupMenu(String value) {
  print("PopupMenu: $value");
}

void _onClickMapa() {}

void _onClickVideo() {}
