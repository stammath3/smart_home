import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:smarthomev_2/data/user.dart';
import 'package:smarthomev_2/view/english/profile.dart';
import 'package:smarthomev_2/view/english/profilewithout.dart';
import 'package:smarthomev_2/view/english/stats_screen.dart';

import '../../utilities/app_styles.dart';
import 'home.dart';

class BottomNav extends StatefulWidget {
  User user;
  int id;

  BottomNav({Key? key, required this.user, required this.id}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const Text("Search"),
    StatsScreen(),
    MyProfilew()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("tapped index is $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: _widgetOptions[_selectedIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Styles.textColor,
      //   onPressed: () => print("hello world"),
      //   tooltip: 'Add Device',
      //   child: Icon(Icons.add),
      //   elevation: 5,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(20),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Styles.textColor,
        unselectedItemColor: Styles.textColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.offline_bolt_outlined),
            activeIcon: Icon(Icons.offline_bolt),
            label: "Electricty",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
