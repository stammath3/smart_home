import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smarthomev_2/view/english/smart_devices/air_condition.dart';
import 'package:smarthomev_2/view/english/smart_devices/lamp.dart';
import 'package:smarthomev_2/view/english/smart_devices/smart_tv.dart';
import 'package:smarthomev_2/view/english/smart_devices/speaker.dart';
import '../../utilities/app_styles.dart';
import 'home_view/rooms.dart';
import 'home_view/smartDevice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> entries = [];
  final textController = TextEditingController();
  final List images = [];

  List mySmartDevices = [
    ["Smart Light", "assets/images/lamp_off.png", true],
    ["Smart AC", "assets/images/air_off.png", false],
    ["Smart TV", "assets/images/1.png", false],
    ["Smart Speak", "assets/images/Speaker.png", false],
  ];

  List<Widget> navigation = <Widget>[
    SmartLamp(),
    Air_Condition(),
    SmartTV(),
    Speaker()
  ];

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const Gap(40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/home.png"),
                          ),
                        ),
                      ),
                      Gap(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "",
                            style: Styles.headtyle3,
                          ),
                          Gap(5),
                          Text(
                            "Hi Max",
                            style: Styles.headerStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(15),
                      Text(
                        "Welcome to your smart home",
                        style: Styles.textStyle,
                      ),
                    ],
                  ),
                  const Gap(20),
                  //Room Widget
                  //RoomContainer(),
                  const Gap(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Smart Devices",
                        style: Styles.headStyle2,
                      ),
                      InkWell(
                        onTap: () {
                          print("you are tapped");
                        },
                        child: Text(
                          "View all",
                          style: Styles.textStyle
                              .copyWith(color: Styles.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(5),

            // grid
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => navigation[index],
                        ),
                      );
                    },
                    child: SmartDeviceBox(
                      smartDeviceName: mySmartDevices[index][0],
                      iconPath: mySmartDevices[index][1],
                      powerOn: mySmartDevices[index][2],
                      onChanged: (value) => powerSwitchChanged(value, index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
