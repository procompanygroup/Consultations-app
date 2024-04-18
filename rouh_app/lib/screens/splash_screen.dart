import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controllers/globalController.dart';
import '../models/country.dart';
import 'login/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rouh_app/mystyle/constantsColors.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isLoadingCountrys = true;
  bool isLoadingVideo = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideo();
    fillGlobalCountryList();


  }

  Future<void> initializeVideo() async {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/video/splash_screen.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
    setState(() {
      isLoadingVideo =false;
    });

    // Use the controller to loop the video.
    _controller.setLooping(false);

    _controller.play();



    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 6), () async {
      while(isLoadingCountrys)
        {
          await Future.delayed(const Duration(seconds: 1));
        };
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));

    });


  }
  Future<void> fillGlobalCountryList() async {

    globalCountryList =await Country.readJson();
    // print("globalCountryList.first:" + globalCountryList.first.code.toString());
      try {
       var response = await http.get(Uri.parse('http://ip-api.com/json'));
       globalCountryIp = json.decode(response.body)['countryCode'].toString();
      } catch (err) {
        globalCountryIp = '';
      }
    // print("globalCountryIp: " + globalCountryIp);
      setState(() {
        isLoadingCountrys =false;
      });
     print("isLoadingCountrys: " + isLoadingCountrys.toString());

  }
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            /*
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_background.jpg"),
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
        */
            /*
            Container(
                width: double.infinity,
                child: Lottie.asset(
                  'assets/data/splash_screen.json',
                  // width: 200,
                  // height: 200,
                  // fit: BoxFit.fill,
                  fit: BoxFit.cover,
                )));
      */
    Container(
      // color: myprimarycolor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        // color: Colors.white,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // child: !isLoadingVideo? FutureBuilder(
        child:  FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
          },
        ),
      ));
  }
}
