import 'package:carros/pages/favoritos/carro_dao.dart';

import '../carro/carro.dart';
import 'favorito.dart';
import 'favorito_dao.dart';

class FavoritoService {
  static favoritar(Carro c) async {
    Favorito? f = Favorito(
      id: c.id,
      nome: c.nome,
    );

    final dao = FavoritoDAO();

    final bool exists = await dao.exists(c.id!);

    if (exists) {
      dao.delete(c.id!);
    } else {
      dao.save(f);
    }

    dao.save(f);
  }

  static Future<List<Carro>?> getCarros() async {
    List<Carro>? carros = await CarroDAO()
        .query("select * from carro c c favorito f where c.id = f.id");
    return carros;
  }
}
