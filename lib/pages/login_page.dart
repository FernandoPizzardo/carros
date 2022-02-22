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
        title: Text("Carros"),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
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

  _onClickLogin() {
    String login = _tLogin.text;
    String senha = _tSenha.text;
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print("Login: $login, Senha: $senha");
  }
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
