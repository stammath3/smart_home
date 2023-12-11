import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


import '../../../utilities/app_styles.dart';

// ignore: camel_case_types
class Air_Condition extends StatefulWidget {
  const Air_Condition({Key? key}) : super(key: key);

  @override
  State<Air_Condition> createState() => _Air_ConditionState();
}

// ignore: camel_case_types
class _Air_ConditionState extends State<Air_Condition> {
  List<bool> _isSelected = [false, false, false];
  List<bool> onoff = [false];
  bool pressed = true;
  List<bool> isSelected = [false, false, false];
  List<IconData> iconList = [Icons.wifi, Icons.mic, Icons.lock_clock];
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.bgColor,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          //title: Text(""),
          backgroundColor: Styles.bgColor,
          elevation: 0,
        ),
        body: ListView(
            padding: EdgeInsets.only(top: 40, left: 15, right: 10),
            // Vertical scroll.
            scrollDirection: Axis.vertical,
            children: <Widget>[
              //text
              RichText(
                  text: TextSpan(
                text: "Air Condition",
                style: TextStyle(
                  color: Styles.textColor,
                  fontSize: 25,
                ),
              )),
              //1) toggle
              SizedBox(height: 25),
              ToggleButtons(
                hoverColor: Styles.whiteColor,
                renderBorder: false,
                children: <Widget>[
                  pressed == true
                      ? Icon(
                          Icons.toggle_off,
                          color: Styles.whiteColor,
                          size: 55,
                        )
                      : Icon(Icons.toggle_on,
                          color: Styles.textColor, size: 55),
                ],
                onPressed: (int index) {
                  setState(() {
                    onoff[index] = !onoff[index];
                    pressed = !pressed;
                  });
                },
                isSelected: onoff,
              ),

              //2) icon +battery + pososto volume
              SizedBox(height: 25),
              Container(
                height: 30,
                child: ListView(
                    padding: EdgeInsets.only(left: 15, right: 10, bottom: 10),
                    // Horizontal scroll.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.power),
                      RichText(
                          text: TextSpan(
                        text: "80 %",
                        style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 20,
                        ),
                      )),
                      SizedBox(width: 190),
                      RichText(
                          text: TextSpan(
                        text: "${_currentSliderValue.round()} %",
                        style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 20,
                        ),
                      )),
                    ]),
              ),

              //3) listview speaker + bar

              Container(
                height: 300,
                child: ListView(

                    // Horizontal scroll.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/air_off.png'),
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(width: 70),
                      RotatedBox(
                          quarterTurns: -1,
                          child: Slider(
                            activeColor: Styles.textColor,
                            thumbColor: Styles.textColor,
                            inactiveColor: Colors.grey,
                            value: _currentSliderValue,
                            max: 100,
                            divisions: 5,
                            label:
                                "${_currentSliderValue.round().toString()} %",
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ))
                    ]),
              ),

              //4) buttons

              Container(
                height: 50,
                child: ListView(

                    // Horizontal scroll.
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      SizedBox(width: 25),
                      ToggleButtons(
                        renderBorder: false,
                        borderRadius: BorderRadius.circular(30),
                        fillColor: Styles.textColor,
                        selectedColor: Styles.whiteColor,
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                //border: Border.all(),

                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: Icon(Icons.air, size: 25)),
                          Container(
                              decoration: BoxDecoration(
                                //border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: Icon(Icons.battery_saver, size: 25)),
                          Container(
                              decoration: BoxDecoration(
                                //border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: Icon(Icons.lock_clock, size: 25)),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            _isSelected[index] = !_isSelected[index];
                          });
                        },
                        isSelected: _isSelected,
                      ),
                    ]),
              ),
              Gap(20),
            ]));
  }
}
