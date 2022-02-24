import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_api.dart';
import 'package:carros/pages/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final double _height = 20;
  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carros"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            AppText(
              context: context,
              label: "Login",
              hint: "Digite seu E-mail",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            AppText(
              context: context,
              label: "Senha",
              hint: "Digite sua Senha",
              password: true,
              controller: _tSenha,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: _height,
            ),
            AppButton(
              text: "Login",
              onPressed: _onClickLogin,
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin(BuildContext context) async {
    String login = _tLogin.text;
    String senha = _tSenha.text;
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print("Login: $login, Senha: $senha");

    Usuario? ok = await LoginApi.login(login, senha);
    if (ok != null) {
      push(context, const HomePage());
    } else {
      alert(context, "Erro", "Login ou senha inválidos");
    }
  }

  alert(BuildContext context, String title, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  String? _validateLogin(String? text) {
    (String? text) {
      if (text!.isEmpty) {
        return "Digite o Login";
      }
      return null;
    };
    String? _validateSenha(String? text) {
      (String? text) {
        if (text!.isEmpty) {
          return "Digite a Senha";
        }
        if (text.length < 3) {
          return "Senha curta demais";
        }
        return null;
      };
    }
  }
}
