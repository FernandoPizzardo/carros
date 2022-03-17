import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_form_page.dart';
import 'package:carros/pages/carro/loripsum_api.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  State<CarroPage> createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();
  Color color = Colors.grey;
  Carro? carro;
  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(widget.carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });

    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome.toString()),
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
          PopupMenuButton<String>(
              onSelected: _onClickPopupMenu,
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
        CachedNetworkImage(
          imageUrl: widget.carro.urlFoto ?? "https://i.imgflip.com/64sz4u.png",
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
          color: color,
          onPressed: _onClickFavoritos,
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
              widget.carro.nome.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.carro.tipo.toString(),
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
          widget.carro.descricao.toString(),
          fontSize: 16,
          color: Colors.white,
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return text(snapshot.data.toString(), color: Colors.white);
            } else {
              return const CircularProgressIndicator();
            }
          },
        )
      ],
    );
  }

  Future<void> _onClickFavoritos() async {
    bool favorito = await FavoritoService.favoritar(widget.carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        push(
            context,
            CarroFormPage(
              carro: carro,
            ));
        break;
      case "Deletar":
        print("Deletar");
        break;
    }
  }
}

void _onClickMapa() {}

void _onClickVideo() {}
