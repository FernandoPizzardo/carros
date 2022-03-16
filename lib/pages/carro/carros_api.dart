import 'dart:convert';
import 'package:carros/pages/login/usuario.dart';

import '../favoritos/carro_dao.dart';
import 'carro.dart';
import 'package:http/http.dart' as http;

class tipoCarro {
  static const String classicos = "classicos";
  static const String esportivos = "esportivos";
  static const String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var uri = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo');
    var response = await http.get(uri, headers: headers);
    String json = response.body;
    List list = jsonDecode(json);
    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();
    final dao = CarroDAO();

    // for (Carro c in carros) {
    //   dao.save(c);
    // }

    return carros;
  }
}
