import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

import '../api_response.dart';

class LoginBloc {
  Future<ApiResponse> login(String? login, String? senha) async {
    ApiResponse response = await LoginApi.login(login, senha);
    return response;
  }
}
