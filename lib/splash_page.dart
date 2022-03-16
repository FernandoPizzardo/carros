import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/favoritos/db_helper.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () {

    // });
    Future futureA = DatabaseHelper.getInstance().db;
    Future futureB = Future.delayed(const Duration(seconds: 3));
    Future<Usuario> futureC = Usuario.get();
    // future.then((Usuario user) {
    //   if (user != null) {
    //     push(context, HomePage(), replace: true);
    //   }
    // });
    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: CachedNetworkImage(
              imageUrl:
                  "https://c.tenor.com/zxgPvZoz_4AAAAAd/crash-car-crash.gif"),
        ),
      ),
    );
  }
}
