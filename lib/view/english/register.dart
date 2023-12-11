import 'package:flutter/material.dart';
import 'package:smarthomev_2/view/english/registerwidget.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              // child: ComboMenu()
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