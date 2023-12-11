import 'package:flutter/material.dart';
import 'package:smarthomev_2/view/english/profileWidgets.dart';
import '../../data/user.dart';


class MyProfile extends StatefulWidget {
  final User user;
  final int id;

  MyProfile({
    super.key,
    required this.user, 
    required this.id});
 
  @override
  State<MyProfile> createState() => _MyProfileState();
}

 
class _MyProfileState extends State<MyProfile> {
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
              CustomRow(icon: Icons.mail, text: widget.user.getEmail()),
              SizedBox(height: 50),
              CustomRow(icon: Icons.key, text: widget.user.getPassword()),
              SizedBox(height: 50),
              CustomRow(icon: Icons.place, text: widget.user.getCountry()),
          ]
        )
      )  
    );
  }
}