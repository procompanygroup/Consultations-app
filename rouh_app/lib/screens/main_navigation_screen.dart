import 'package:flutter/material.dart';
import 'package:rouh_app/mystyle/constantsColors.dart';
import 'package:rouh_app/screens/service/service_application_screen.dart';
import 'experts/experts_screen.dart';
import 'service/service_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<Color> colorBorder = [
      Color(0xff015DAC),
      Colors.transparent,
      Colors.transparent,
      Colors.transparent
    ];
    const List<Widget> _pages = <Widget>[
      ServiceScreen(),
      ServiceApplicationScreen(serviceId: 1),
      ExpertsScreen(),

      Text(
        'Index 3: Settings',
      ),
      // HomeScreen(),
      // ServiceScreen(),
      // ProfileScreen(),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Demo'),
      // ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [colorBorder[_selectedIndex], Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.0), topRight: Radius.circular(35.0)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/home.svg",
                  fit: BoxFit.cover,
                  color:
                      _selectedIndex == 0 ? mysecondarycolor : Colors.black26,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/couple-icon.svg",
                  color:
                      _selectedIndex == 1 ? mysecondarycolor : Colors.black26,
                ),
                label: 'service',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/experts.svg",
                  color:
                      _selectedIndex == 2 ?mysecondarycolor : Colors.black26,
                ),
                label: 'experts',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/settings.svg",
                  color:
                      _selectedIndex == 3 ? mysecondarycolor : Colors.black26,
                ),
                label: 'profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
