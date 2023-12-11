import 'package:flutter/material.dart';

import 'LoginWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child:Center(
        child: Padding(
         padding: EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
              height: 100,
              width: 150,
              child:Row(children: [
                IconB()
                 ]
                )
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 200),
                child: ComboMenu()),
              Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: LoginForm(),
               ),
               TextLoginOther(),
               Padding(
               padding: EdgeInsets.only(left: 130),
               child:OtherIcons()),
               SizedBox(height: 100),
               Rectang()
              ],
            ),
          ),
       )
    )
  );
}

 
}