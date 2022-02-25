import 'dart:convert';
import 'carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    var uri =
        Uri.parse('https://carros-springboot.herokuapp.com/api/v1/carros/');
    var response = await http.get(uri);
    String json = response.body;
    List list = jsonDecode(json);
    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();
    return carros;
  }
}
