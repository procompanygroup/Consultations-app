import 'package:flutter/material.dart';
import 'mystyle/constantsColors.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/login_verification_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: mysecondarycolor,
          // brightness: Brightness.light,
        ),


        primarySwatch: mysecondarycolor,
        scaffoldBackgroundColor: Colors.grey[100],
        // buttonTheme: ButtonThemeData(
        //   buttonColor: myprimercolor,         //  <-- light color
        //   textTheme: ButtonTextTheme.primary, //  <-- dark text for light background
        // )
      ),
      routes: {
        //   // When navigating to the "/" route, build the FirstScreen widget.
        '/splashScreen': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        // '/service': (context) => const ServiceScreen(),
        // '/experts': (context) => const ExpertsScreen(),
        // '/profile': (context) => const ProfileScreen(),
        // '/record': (context) => const RecordScreen(),
        // '/playerAudio': (context) => const PlayerAudioScreen(),
        // '/recordAndPlay': (context) => const RecordAndPlayScreen(),
        '/loginVerification': (context) => const LoginVerificationScreen(),

        //   // When navigating to the "/second" route, build the SecondScreen widget.
        //   '/order/profile': (context) => const ProfileScreen(),
      },
      // home:  LoginScreen(),
      home:  SplashScreen(),
    );
  }
}

