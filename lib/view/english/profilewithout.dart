import 'package:flutter/material.dart';
import 'package:smarthomev_2/view/english/profileWidgets.dart';
import '../../data/user.dart';


class MyProfilew extends StatefulWidget {


  MyProfilew({
    super.key,});
 
  @override
  State<MyProfilew> createState() => _MyProfilewState();
}

 
class _MyProfilewState extends State<MyProfilew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:EdgeInsets.only(top: 100),
        child: Column(children: [
              Image(image: AssetImage('assets/images/home.png')),
              SizedBox(height: 20),
              Text( '   SmartHome',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              SizedBox(height: 150),
              CustomRow(icon: Icons.mail, text: "email"),
              SizedBox(height: 50),
              CustomRow(icon: Icons.key, text: "password"),
              SizedBox(height: 50),
              CustomRow(icon: Icons.place, text: "country"),
          ]
        )
      )  
    );
  }
}