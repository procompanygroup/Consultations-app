import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rouh_app/screens/login/register.dart';
import 'package:rouh_app/widgets/custom_appbar.dart';

import '../../controllers/phone_auth_controller.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../main_navigation_screen.dart';

class LoginVerificationScreen extends StatefulWidget {
  final fullNumber, verifyCode;
  const LoginVerificationScreen({Key? key, this.fullNumber, this.verifyCode})
      : super(key: key);

  @override
  State<LoginVerificationScreen> createState() =>
      _LoginVerificationScreenState();
}

class _LoginVerificationScreenState extends State<LoginVerificationScreen> {
  int _start = 30;
  late Timer _timer;
  String start = "30";
  bool resendButtonisEnable = false;
  PhoneAuthController controller = PhoneAuthController();
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_start <= 0) {
            resendButtonisEnable = true;
            timer.cancel();
          } else {
            _start--;
            start = _start.toString().padLeft(2, "0");
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String verifyCode = widget.verifyCode;
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*
      backgroundColor: myprimercolor,
      appBar: AppBar(
        toolbarHeight: bodyHeight * 0.20,
        iconTheme: IconThemeData(
          color: mysecondarycolor, //change your color here
        ),
        backgroundColor: myprimercolor,
        title: Text(
          "Active Application",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      */
      body: Stack(
        children: [
          const CustomAppBar(title: "Activate App"),
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    height: (bodyHeight * 0.80) * 0.33,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SvgPicture.asset(
                          'assets/svg/shield-lock-line-icon.svg',
                          color: Colors.grey.shade300,
                          semanticsLabel: 'Label'),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Center(
                              child: Text(
                                "Please enter the verification code for the number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: myprimercolor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 45),
                                        height: (screenWidth - 80) / 6,
                                        width: (screenWidth - 100) / 6,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          onSaved: (pin1) {},
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  // width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "0",
                                              fillColor: Colors.grey.shade100,
                                              contentPadding: EdgeInsets.only(
                                                bottom: 45 /
                                                    2, // HERE THE IMPORTANT PART
                                              )),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 45),
                                        height: (screenWidth - 80) / 6,
                                        width: (screenWidth - 100) / 6,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          onSaved: (pin2) {},
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  // width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "0",
                                              fillColor: Colors.grey.shade100,
                                              contentPadding: EdgeInsets.only(
                                                bottom: 45 /
                                                    2, // HERE THE IMPORTANT PART
                                              )),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 45),
                                        height: (screenWidth - 80) / 6,
                                        width: (screenWidth - 100) / 6,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          onSaved: (pin3) {},
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  // width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "0",
                                              fillColor: Colors.grey.shade100,
                                              contentPadding: EdgeInsets.only(
                                                bottom: 45 /
                                                    2, // HERE THE IMPORTANT PART
                                              )),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 45),
                                        height: (screenWidth - 80) / 6,
                                        width: (screenWidth - 100) / 6,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          onSaved: (pin4) {},
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  // width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "0",
                                              fillColor: Colors.grey.shade100,
                                              contentPadding: EdgeInsets.only(
                                                bottom: 45 /
                                                    2, // HERE THE IMPORTANT PART
                                              )),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 45),
                                        height: (screenWidth - 80) / 6,
                                        width: (screenWidth - 100) / 6,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          onSaved: (pin5) {},
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  // width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "0",
                                              fillColor: Colors.grey.shade100,
                                              contentPadding: EdgeInsets.only(
                                                bottom: 45 /
                                                    2, // HERE THE IMPORTANT PART
                                              )),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, maxWidth: 45),
                                        height: (screenWidth - 80) / 6,
                                        width: (screenWidth - 100) / 6,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                          },
                                          onSaved: (pin6) {},
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey.shade300,
                                                  // width: 2.0,
                                                ),
                                              ),
                                              filled: true,
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              hintText: "0",
                                              fillColor: Colors.grey.shade100,
                                              contentPadding: EdgeInsets.only(
                                                bottom: 45 /
                                                    2, // HERE THE IMPORTANT PART
                                              )),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                "00:$start",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: mysecondarycolor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Resend verification code",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: resendButtonisEnable
                                ? () async {
                                    verifyCode = await controller.sendSMS(
                                        toPhoneNumber: (widget.fullNumber));
                                    setState(() {
                                      _start = 30;
                                      resendButtonisEnable = false;
                                    });
                                    startTimer();
                                  }
                                : () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 10.0),
                            child: Container(
                              width: double.infinity,
                              child: TextButton(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                style: bs_flatFill(context),
                                onPressed: () async {
/*
                                  // dina
                                  User user = User();
                                  print("Get Token");
                                  var token = await user.login(
                                      mobile: widget.fullNumber);
                                   print("Token: " + token.toString());
                                  if (token != "") {
                                    const storage = FlutterSecureStorage();
                                    // for write
                                    await storage.write(
                                        key: 'token',
                                        value: token); // Save token
                                    // get user Info
                                    var userInfo = await user.getUser(
                                        mobile: widget.fullNumber);

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MainNavigationScreen()),
                                        (route) =>
                                            route.settings.name ==
                                            '/mainNavigation');
                                  } else {
                                     // Navigator.of(context)
                                     //     .pushReplacement(MaterialPageRoute(
                                     //   builder: (context) => const Register(),
                                     // ));
                                  }
                                  */
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              MainNavigationScreen()),
                                          (route) =>
                                      route.settings.name ==
                                          '/mainNavigation');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
