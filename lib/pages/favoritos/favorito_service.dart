import 'package:carros/pages/favoritos/carro_dao.dart';

import '../carro/carro.dart';
import 'favorito.dart';
import 'favorito_dao.dart';

class FavoritoService {
  static Future<bool> favoritar(Carro c) async {
    Favorito? f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id!);

    if (exists) {
      dao.delete(c.id!);
      return false;
    } else {
      dao.save(f);
      return true;
    }
  }

  static Future<List<Carro>?> getCarros() async {
    List<Carro>? carros = await CarroDAO()
        .query("select * from carro c, favorito f where c.id = f.id");
    return carros;
  }

  static Future<bool> isFavorito(Carro c) async {
    final dao = FavoritoDAO();

    final exists = await dao.exists(c.id!);

    return exists;
  }
}
