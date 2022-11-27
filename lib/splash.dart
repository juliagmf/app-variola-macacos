import 'dart:async';

import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../home.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  // 3s de tempo de tela
  startTime() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

// rota para tela de login
  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

// método para realizar a inicialização
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

// método de construção
//subscribe to the object
  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kgreen,
            ),
          ),
          Center(
            child: Container(
              child: Image.asset("assets/monkeypox.png"),
            ),
          )
        ],
      ),
    );
  }
}
