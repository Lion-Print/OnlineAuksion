import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Center(child: Text('dfghrtsdhjryh')),
    Center(child: Text('Home')),
    Center(child: Text('Home')),
    Center(child: Text('Home')),
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: h * 0.08,
        title: const Row(
          children: [
            Text(
              "Lion",
              style: TextStyle(color: MyColors.Mywhite,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Print",
              style: TextStyle(color: MyColors.Mywhite,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        backgroundColor: MyColors.Mypurple2,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.Myblue12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: Colors.white,
              height: h * 0.03,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/users.svg',
              color: Colors.white,
              height: h * 0.03,
            ),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/add.svg',
              color: Colors.white,
              height: h * 0.03,
            ),
            label: 'Add',
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