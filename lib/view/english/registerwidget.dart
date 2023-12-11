import 'package:flutter/material.dart';
import 'package:smarthomev_2/view/english/register.dart';

import '../../data/user.dart';
import '../../utilities/database_helper.dart';
import '../czech/registercz.dart';
import 'login.dart';


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
                    MaterialPageRoute(builder: (context) => RegisterPagecz()));
              } else if (value == 'English') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
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

class BackButtone extends StatefulWidget {
  const BackButtone({super.key});

  @override
  State<BackButtone> createState() => _BackButtoneState();
}

class _BackButtoneState extends State<BackButtone> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white10,
          elevation: 0.0,
          shadowColor: Colors.transparent),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Icon(Icons.arrow_back, color: Colors.black, size: 30),
    );
  }
}

class RegisterText extends StatelessWidget {
  const RegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Create Smart Home Account',
        style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold));
  }
}

class TextRegisterT extends StatelessWidget {
  const TextRegisterT({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        '''We'll store your data in accordance with the laws and the regultions of the country or region that you select.''',
        style: TextStyle(fontSize: 15));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

String _fullname = "", _password = "", _email = "", _country = "";

class _RegisterFormState extends State<RegisterForm> {
  Future<void> fetchAndSetData() async {
    final datalist = await DatabaseHelper.getData("users");
    print(datalist);
  }

  databaseInsert(x) async {
    await DatabaseHelper.insert('users', x);
  }

  final _formkeyr = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 410,
        width: 300,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Form(
                key: _formkeyr,
                child: Column(children: [
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Country',
                      ),
                      onChanged: (val) => _country = val,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid Password';
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                      ),
                      onChanged: (val) => _fullname = val,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid Password';
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                      ),
                      onChanged: (val) => _email = val,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid Password';
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onChanged: (val) => _password = val,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid Password';
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid Password';
                        }
                        return null;
                      })
                ])),
          ],
        ),
      ),
      SizedBox(height: 10),
      Container(height: 20, child: TextA()),
      SizedBox(height: 10),
      Container(
          height: 20,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 51.5), child: TextB()),
              Padding(
                  padding: EdgeInsets.only(right: 10), child: ConfirmButton())
            ],
          )),
      SizedBox(height: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            minimumSize: Size(310, 33)),
        onPressed: () async {
           final isValid = _formkeyr.currentState!.validate();
           if (isValid) {
          User myUser = new User(
              country: _country,
              fullname: _fullname,
              email: _email,
              password: _password);
          var myMapUser = myUser.toMap();
          await databaseInsert(myMapUser);
          User? user = (await DatabaseHelper.readUser(_email, _password));
          if (user == null) {
            print("null user");
            return;
          }
          int? myId = await DatabaseHelper.readUsersId(_email, _password);
          if (myId == null) {
            return;
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (Route<dynamic> route) => false);
              }else {
                print("UnSuccesfull");
              }
        },
        child: Text('Sign Up'),
      )
    ]);
  }
}

class ConfirmButton extends StatefulWidget {
  const ConfirmButton({super.key});

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  bool hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: RawMaterialButton(
          onPressed: () {
            setState(() {
              hasBeenPressed = !hasBeenPressed;
            });
          },
          elevation: 5.0,
          highlightElevation: 10.0,
          highlightColor: Colors.transparent,
          fillColor: hasBeenPressed ? Colors.black : Colors.white,
          shape: CircleBorder(),
        ));
  }
}

class TextA extends StatelessWidget {
  const TextA({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('''Ive read and aggreed to SmartHome Account's''');
  }
}

class TextB extends StatelessWidget {
  const TextB({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '''User Aggreement ''',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        children: const <TextSpan>[
          TextSpan(
              text: 'and ',
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black)),
          TextSpan(
              text: 'Privacy Police',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class RichTextRegister extends StatelessWidget {
  const RichTextRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '''I've read and aggreed to SmartHome Account's ''',
        style: DefaultTextStyle.of(context).style,
        children: const <TextSpan>[
          TextSpan(
              text: 'User Aggreement ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'and '),
          TextSpan(
              text: 'Privacy Police',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
