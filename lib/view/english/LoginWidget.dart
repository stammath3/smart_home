import 'package:flutter/material.dart';
import 'package:smarthomev_2/view/english/profile.dart';
import 'package:smarthomev_2/view/english/register.dart';

import '../../data/user.dart';
import '../../utilities/database_helper.dart';
import '../czech/logincz.dart';
import 'bottomNav.dart';
import 'login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _password = "", _email = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your email",
                ),
                onChanged: (val) => _email = val,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email';
                  }
                  return null;
                }),
            SizedBox(height: 10),
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter your password",
                ),
                onChanged: (val) => _password = val,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid password';
                  }
                  return null;
                }),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 175),
              child: TextForgotPassword(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  minimumSize: Size(500, 33)),
              onPressed: () async {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  User? user = await DatabaseHelper.readUser(_email, _password);
                  if (user == null) {
                    //ean den typarxei o xrhsths ektypwnei mhnyma kai den mpainei
                    print("null user");
                    return;
                  }
                  int? myId =
                      await DatabaseHelper.readUsersId(_email, _password);
                  if (myId == null) {
                    return;
                  }
                  Navigator.of(context).pushAndRemoveUntil(
                      //
                      MaterialPageRoute(
                        builder: (context) => BottomNav(
                          user: user,
                          id: myId,
                        ),
                      ),
                      (Route<dynamic> route) => false);
                } else {
                  print("UnSuccessfull");
                }
              },
              child: Text('Log in'),
            ),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(right: 170), child: CreateAccText()),
          ],
        ));
  }
}

class IconB extends StatelessWidget {
  const IconB({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image(image: AssetImage('assets/images/home.png')),
      SizedBox(height: 10),
      TextIcon()
    ]);
  }
}

class TextIcon extends StatelessWidget {
  const TextIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '   SmartHome',
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
    );
  }
}

class TextForgotPassword extends StatelessWidget {
  const TextForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Text Clicked');
      },
      child: Text('Forgot Password?', style: TextStyle(color: Colors.grey)),
    );
  }
}

class CreateAccText extends StatelessWidget {
  const CreateAccText({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Text('Create Account',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
    );
  }
}

class TextLoginOther extends StatefulWidget {
  const TextLoginOther({super.key});

  @override
  State<TextLoginOther> createState() => _TextLoginOtherState();
}

class _TextLoginOtherState extends State<TextLoginOther> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '_______________ Other Ways To Sign In _______________',
    );
  }
}

class OtherIcons extends StatelessWidget {
  const OtherIcons({super.key});

  final bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            InkWell(
                onTap: () {
                  print('Text Clicked');
                },
                child: Icon(
                  Icons.facebook,
                  color: Colors.black,
                  size: 50.0,
                )),
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.mail,
              color: Colors.black,
              size: 50.0,
            ),
          ],
        ));
  }
}

class Rectang extends StatelessWidget {
  const Rectang({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, minimumSize: Size(200, 10)),
        onPressed: () {},
        child: Text(''));
  }
}

class ElavatedButton extends StatelessWidget {
  const ElavatedButton({
    Key? key,
    required GlobalKey<FormState> formkey,
  })  : _formkey = formkey,
        super(key: key);

  final GlobalKey<FormState> _formkey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          minimumSize: Size(500, 33)),
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        }
      },
      child: Text('Log in'),
    );
  }
}

class ComboMenu extends StatefulWidget {
  const ComboMenu({super.key});

  @override
  State<ComboMenu> createState() => _ComboMenuState();
}

class _ComboMenuState extends State<ComboMenu> {
  final items = ['English', 'Czech'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(),
      child: Column(children: [
        DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          items: items.map(buildMenuItem).toList(),
          value: 'English',
          iconSize: 36,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              this.value = value;
              if (value == 'Czech') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPagecz()));
              } else if (value == 'English') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
            });
          },
        )),
      ]),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      );
}
