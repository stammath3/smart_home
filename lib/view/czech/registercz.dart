import 'package:flutter/material.dart';

import '../english/registerwidget.dart';



class RegisterPagecz extends StatefulWidget {
  const RegisterPagecz({super.key});

  @override
  State<RegisterPagecz> createState() => _RegisterPageStatecz();
}

class _RegisterPageStatecz extends State<RegisterPagecz> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:  SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Padding(padding: EdgeInsets.only(right: 250),
              child:BackButtone()),
              Padding(
              padding: EdgeInsets.only(right: 130),
              child: ComboMenu()
              ),
              SizedBox(height: 20),
              Padding(padding: EdgeInsets.only(right: 10),
              child: RegisterText(),
              ),
              SizedBox(height: 20),
              Padding(padding: EdgeInsets.all(18.0),
              child: TextRegisterT()),
              RegisterForm(),
            ],
          ),
        )
      );
  }
}