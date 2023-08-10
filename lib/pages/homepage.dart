import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bottomBar/company.dart';
import '../bottomBar/page3.dart';
import '../bottomBar/user_info.dart';
import '../resources/colors.dart';
var counters;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    // NavHome(),
    // InfoUsers(),
    // AddUserPage(),
    // NavSettings()
    Company(),
    AllUsers(),
    InfoUsers(),
    InfoUsers(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.removeObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.colorTwo,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/home_icons.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              color: Colors.white,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svgs/home_icon.svg',
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/users.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              color: Colors.white,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svgs/users.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              colorFilter: const ColorFilter.mode(
                Colors.orange,
                BlendMode.srcATop,
              ),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/box.svg',
              height: MediaQuery.of(context).size.height * 0.03,

            ),
            activeIcon: SvgPicture.asset(
              'assets/svgs/box.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              colorFilter: const ColorFilter.mode(
                Colors.orange,
                BlendMode.srcATop,
              ),
                  ),
            label: 'camera',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svgs/settings_icons.svg',
              height: MediaQuery.of(context).size.height * 0.03,
              color: Colors.white,
            ),
            activeIcon: SvgPicture.asset(
              'assets/svgs/settings_icon.svg',
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        elevation: 5,
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.indigo),
        onTap: _onItemTapped,
      ),
    );
  }
}