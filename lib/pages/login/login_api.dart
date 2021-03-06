import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(
      String? login, String? senha) async {
    try {
      Uri? url =
          Uri.parse("http://carros-springboot.herokuapp.com/api/v2/login");
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
      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);

        user.save();

        Usuario user2 = await Usuario.get();

        print(user2.toString());

        return ApiResponse.ok(user);
      } else {
        throw ApiResponse.error(mapResponse["error"]);
      }
    } catch (error, exception) {
      print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }
}
