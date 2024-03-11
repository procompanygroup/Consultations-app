import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app_experts/bloc/audio_file/audio_file_cubit.dart';

import 'bloc/expert/expert_information_cubit.dart';
import 'mystyle/constantsColors.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  // runApp(const MyApp());

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ExpertInformationCubit>(
        create: (BuildContext context) => ExpertInformationCubit(),
      ),
      BlocProvider<AudioFileCubit>(
        create: (BuildContext context) => AudioFileCubit(),
      ),

    ],
    child: MyApp(),
  ), );
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
        // Set Noto Kufi Arabic as the default app font.
        fontFamily: 'Noto Kufi Arabic',
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

      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routes: {
        //   // When navigating to the "/" route, build the FirstScreen widget.
        '/splashScreen': (context) => const SplashScreen(),
        // '/login': (context) => const LoginScreen(),
        // '/loginVerification': (context) => const LoginVerificationScreen(),
        '/mainNavigation': (context) => const MainNavigationScreen(),

        //   // When navigating to the "/second" route, build the SecondScreen widget.
        //   '/order/profile': (context) => const ProfileScreen(),
      },
      // home:  LoginScreen(),
      home:  SplashScreen(),
    );
  }
}

