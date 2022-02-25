import 'dart:convert';
import 'carro.dart';
import 'package:http/http.dart' as http;

class tipoCarro {
  static const String classicos = "classicos";
  static const String esportivos = "esportivos";
  static const String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var uri = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo');
    var response = await http.get(uri);
    String json = response.body;
    List list = jsonDecode(json);
    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();
    return carros;
  }
}
