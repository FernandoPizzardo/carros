class Usuario {
  String? login;
  String? nome;
  String? email;
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
    List<String> lista = [];
    for (String role in list) {
      lista.add(role);
    }
    return lista;
  }
}
