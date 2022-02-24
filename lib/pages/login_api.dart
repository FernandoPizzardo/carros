import 'dart:convert';

import 'package:carros/pages/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<Usuario?> login(String? login, String? senha) async {
    Uri url = "http://carros-springboot.herokuapp.com/api/v2/login" as Uri;
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map params = {
      "username": login,
      "password": senha,
    };

    String paramsJson = json.encode(params);

    var response = await http.post(url, body: paramsJson, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String?, dynamic> mapResponse = json.decode(response.body);

    final user = Usuario.fromJson(mapResponse);
  }
}
