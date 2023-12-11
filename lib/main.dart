import 'package:flutter/material.dart';
import 'package:smarthomev_2/view/english/login.dart';
import 'package:wakelock/wakelock.dart';
void main() {

  runApp( SmartHome());
  
}

class SmartHome extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Wakelock.enable();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartHome',
      home: LoginPage(),
    );
  }
}
