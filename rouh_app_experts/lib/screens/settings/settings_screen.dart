import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../bloc/expert/expert_information_cubit.dart';
import '../../controllers/converters.dart';
import '../../controllers/globalController.dart';
import '../../models/country.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isActiveNotification = true;

  @override
  void initState() {
    // TODO: implement initState

    checkNotificationPermissions();

    super.initState();
    //
  }

  Future<void> checkNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      setState(() {
        isActiveNotification = true;
      });
    }
  }

  Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      // Notification permissions granted
    } else if (status.isDenied) {
      // Notification permissions denied
    } else if (status.isPermanentlyDenied) {
      // Notification permissions permanently denied, open app settings
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
            -
            MediaQuery.of(context).padding.top // safe area
            -
            AppBar().preferredSize.height //AppBar
        );

    return Scaffold(
      body: Stack(children: [
        Column(children: [
          // Top
          Container(
            height: bodyHeight * 0.20,
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                // border: Border.all(color: Colors.grey),
                gradient: LinearGradient(
                  colors: [Color(0xff023056), myprimercolor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: (bodyHeight * 0.20) -
                            MediaQuery.of(context).padding.top, // service list,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 20,
                              end: 20,
                            ),
                            child: ElevatedButton(
                              child: SvgPicture.asset(
                                "assets/svg/share-icon.svg",
                                color: myprimercolor,
                                width: 25,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(5),
                                backgroundColor:
                                    Colors.white, // <-- Button color
                                // foregroundColor: Colors.red, // <-- Splash color
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Body
          Container(
            width: screenWidth,
            height: bodyHeight * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              // border: Border.all(color: Colors.grey),
              // color: Colors.white,
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Row1
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        width: screenWidth - 20 - 40,
                        // height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "الإعدادات",
                                  style: TextStyle(
                                      fontSize: 18, color: mysecondarycolor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10.0),
                                child: Divider(color: Colors.grey.shade300),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // notification
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SvgPicture.asset(
                                          "assets/svg/setting-bell-notification-icon.svg",
                                          color: myprimercolor,
                                          width: 25,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "تفعيل الإشعارات",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: SizedBox(
                                        width: 50,
                                        height: 35,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Switch(
                                            value: isActiveNotification,
                                            onChanged: (value) async {
                                              setState(() {
                                                isActiveNotification = value;
                                              });

                                              try {
                                                await requestNotificationPermissions();
                                              } catch (err) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(err.toString()),
                                                ));
                                              }
                                            },
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              // wallet
                              GestureDetector(
                                onTap: () {
                                  print("wallet");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: SvgPicture.asset(
                                            "assets/svg/wallet-icon.svg",
                                            color: myprimercolor,
                                            width: 25,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "المحفظة",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              // statistic
                              GestureDetector(
                                onTap: () {
                                  print("statistic");
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: SvgPicture.asset(
                                            "assets/svg/column-chart-icon.svg",
                                            color: myprimercolor,
                                            width: 25,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "الإحصائيات",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              // help
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: SvgPicture.asset(
                                          "assets/svg/question-inquiry-icon.svg",
                                          color: myprimercolor,
                                          width: 25,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "مركز الدعم والمساعدة",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Row2
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        width: screenWidth - 20 - 40,
                        // height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              // Facebook
                              InkWell(
                                onTap: () {
                                  try {
                                    globalLaunchURL("https://flutter.dev");
                                  } catch (e) {}
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/facebook-round-color-icon.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "تابعنا على فيسبوك",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // X
                              InkWell(
                                onTap: () {
                                  try {
                                    globalLaunchURL("https://flutter.dev");
                                  } catch (e) {}
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/x-social-media-round-icon.png'),
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "تابعنا على إكس",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // logout
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Container(
                        width: screenWidth - 20 - 80,
                        height: 50,
                        child: BlocBuilder<ExpertInformationCubit,
                            ExpertInformationState>(
                          builder: (context, state) {
                            return TextButton(
                              style: bs_flatFill(context, mysecondarycolor),
                              onPressed: () async {
                                try {} catch (e) {}
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/logout-line-icon.svg",
                                    color: Colors.white,
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'تسجيل الخروج',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
