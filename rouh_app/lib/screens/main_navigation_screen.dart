import 'package:flutter/material.dart';
import 'service/service_screen.dart';


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

    const List<Widget> _pages = <Widget>[
      ServiceScreen(),
      Text(
        'Index 1: Business',
      ),
      Text(
        'Index 2: School',
      ),
      Text(
        'Index 3: Settings',
      ),
      // HomeScreen(),
      // ServiceScreen(),
      // ExpertsScreen(),
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
              colors: [Color(0xff015DAC),Color(0xff015DAC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter  ,
            )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0),topRight: Radius.circular(35.0)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 35),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,size: 35) ,
                label: 'sercice',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people,size: 35) ,
                label: 'experts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people,size: 35) ,
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
