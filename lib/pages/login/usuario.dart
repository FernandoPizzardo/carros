import 'dart:convert' as convert;

import '../../utils/prefs.dart';

class Usuario {
  String? login;
  String nome;
  String email;
  String? token;

  List<String>? roles;

  Usuario.fromJson(Map<String?, dynamic> map)
      : nome = map['nome'],
        email = map['email'],
        login = map['login'],
        token = map['token'],
        roles = getRole(map);
  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, token: $token, roles: $roles}';
  }

  static List<String>? getRole(Map<String?, dynamic> map) {
    List list = map["roles"];
    List<String> lista = list.map<String>((e) => e.toString()).toList();
    return lista;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['login'] = this.login;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  void save() {
    Map map = toJson();
    String? json = convert.jsonEncode(map);

    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");

    Map<String?, dynamic> map = convert.jsonDecode(json);

    Usuario user = Usuario.fromJson(map);

    return user;
  }
}
