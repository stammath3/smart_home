import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utilities/app_styles.dart';

class RoomContainer extends StatefulWidget {
  const RoomContainer({Key? key}) : super(key: key);

  @override
  State<RoomContainer> createState() => _RoomContainerState();
}

class _RoomContainerState extends State<RoomContainer> {
  // Room list
  static const List<String> roomList = [
    'Kitchen',
    'Living Room',
    'Bathroom',
    'Bedroom'
  ];

  // Room icon list
  static const List<IconData> roomIconList = [
    Icons.kitchen,
    Icons.living,
    Icons.bathtub,
    FluentSystemIcons.ic_fluent_bed_filled,
  ];

  // List of rooms
  final List<String> entries = [];

  // List of icons
  final List<IconData> images = [];

  // List to track selected rooms
  final List<bool> roomSelected = [];

  String _dropdownValue = roomList.first;

  void onItemTapped(int index) {
    setState(() {
      roomSelected[index] = true;
      for (int i = 0; i < roomSelected.length; i++) {
        if (i != index) {
          roomSelected[i] = false;
        }
      }
    });
  }

  Widget buildRoomButton(int index) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 75,
        width: 75,
        child: Icon(
          roomIconList[index],
          color: roomSelected[index] ? Colors.white : Styles.textColor,
          size: 32,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Styles.textColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
          color: roomSelected[index] ? Styles.textColor : Colors.white,
        ),
      ),
      onTap: () => onItemTapped(index),
      onLongPress: () => onRoomLongPress(index),
    );
  }

  void onRoomLongPress(int index) {
    setState(() {
      print('You removed ${entries[index]}');
      entries.removeAt(index);
      images.removeAt(index);
      roomSelected.removeAt(index);
    });
  }

  Widget buildRoomList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 75,
        child: entries.isNotEmpty
            ? Row(
                children: List.generate(
                  entries.length,
                  (index) => buildRoomButton(index),
                ),
              )
            : const Center(child: Text('No Rooms')),
      ),
    );
  }

  Widget buildAddRoomButton() {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              child: const Icon(
                FluentSystemIcons.ic_fluent_add_filled,
                size: 32,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Styles.textColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
                color: Styles.whiteColor,
              ),
            ),
            Text("New Room", style: Styles.textRoom),
          ],
        ),
      ),
      onTap: () => showRoomSelectionDialog(),
    );
  }

  void showRoomSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          child: Container(
            width: 250, // Adjust the width as needed
            height: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Choose Room"),
                const Gap(15),
                DropdownButton<String>(
                  value: _dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Color(0xFF3b3b3b)),
                  underline: Container(
                    height: 2,
                    color: Styles.textColor,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _dropdownValue = value!;
                    });
                  },
                  items: roomList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildOkButton(),
                    buildCancelButton(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOkButton() {
    return TextButton(
      child: const Text("OK"),
      onPressed: () {
        setState(() {
          final selectedRoomIndex = roomList.indexOf(_dropdownValue);
          if (selectedRoomIndex != -1) {
            images.add(roomIconList[selectedRoomIndex]);
            entries.add(_dropdownValue);
            roomSelected.add(false);
          }
        });
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }

  Widget buildCancelButton() {
    return TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildAddRoomButton(),
        buildRoomList(),
      ],
    );
  }
}
