import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app/bloc/service_inputs/service_input_cubit.dart';
import 'bloc/UserInformation/user_information_cubit.dart';
import 'mystyle/constantsColors.dart';
import 'screens/experts/experts_screen.dart';
import 'screens/service/service_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/login_verification_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/splash_screen.dart';

void main() async{

  Stripe.publishableKey = 'pk_test_51OixcfJifccNTBbxp9uOqin9nVSx6UOb6KE6JaWDnMSbbsxAUICBdBByrXLa8G6sPAhO2PDtBFjTJudgRHOjQDP600pI5owy1m';

  await dotenv.load( fileName: 'assets/payments/payment.env');

  //runApp(const MyApp() );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<UserInformationCubit>(
        create: (BuildContext context) => UserInformationCubit(),
      ),
      BlocProvider<ServiceInputCubit>(
        create: (BuildContext context) => ServiceInputCubit(),
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
        '/login': (context) => const LoginScreen(),
        '/loginVerification': (context) => const LoginVerificationScreen(),
        '/service': (context) => const ServiceScreen(),
        // '/serviceApplication': (context) => const ServiceApplicationScreen(,
        '/experts': (context) => const ExpertsScreen(),
        // '/profile': (context) => const ProfileScreen(),
        // '/record': (context) => const RecordScreen(),
        // '/playerAudio': (context) => const PlayerAudioScreen(),
        // '/recordAndPlay': (context) => const RecordAndPlayScreen(),
         '/mainNavigation': (context) => const MainNavigationScreen(),

        //   // When navigating to the "/second" route, build the SecondScreen widget.
        //   '/order/profile': (context) => const ProfileScreen(),
      },
      // home:  LoginScreen(),
      home:  SplashScreen(),
    );
  }
}

