import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rouh_app/mystyle/constantsColors.dart';
import '../Services/notifi_service.dart';
import '../components/video_player/video_player.dart';
import '../components/video_player_screen.dart';
import '../components/view_video_screen.dart';
import 'experts/experts_screen.dart';
import 'profile/profile_screen.dart';
import 'service/service_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'settings/settings_screen.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;



  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        SecondPage(title:  receivedNotification.payload!),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => SecondPage(title: payload!),
      ));
    });
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    super.initState();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();

    super.dispose();
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
      ExpertsScreen(),
      ProfileScreen(),
      SettingsScreen(),
      // ViewVideoScreen(videoPath: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
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
                label: 'experts',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/my-account-icon.svg",
                  color:
                      _selectedIndex == 2 ?mysecondarycolor : Colors.black26,
                ),
                label: 'profile',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/settings.svg",
                  color:
                      _selectedIndex == 3 ? mysecondarycolor : Colors.black26,
                ),
                label: 'settings',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}



