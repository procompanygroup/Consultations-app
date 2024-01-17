import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
with SingleTickerProviderStateMixin{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen())
      );
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashBackground.jpg"),
            fit: BoxFit.cover,
            // fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ],
        ),
        ),
      );
  }
}
