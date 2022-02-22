import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final double _height = 20;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(16),
            child: ListView(children: [
              _text(
                "Login",
                "Digite seu E-mail",
                controller: _tLogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
              ),
              _text(
                "Senha",
                "Digite sua Senha",
                password: true,
                controller: _tSenha,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: _height,
              ),
              _button(
                "Login",
                Colors.indigo,
                _onClickLogin,
              ),
            ])));
  }

  _text(
    String label,
    String hint, {
    bool password = false,
    controller,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
  }) {
    TextFormField(
      obscureText: password,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: hint),
      keyboardType: keyboardType,
    );
  }

  _button(String text, Color color, Function onPressed) {
    return Container(
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor:
            MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) return color;
          return color;
        })),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        onPressed: onPressed(),
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
