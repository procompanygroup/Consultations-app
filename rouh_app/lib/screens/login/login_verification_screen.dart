import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rouh_app/components/pin_form.dart';
import 'package:rouh_app/screens/login/register.dart';
import 'package:rouh_app/components/custom_appbar.dart';

import '../../controllers/globalController.dart';
import '../../controllers/phone_auth_controller.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../main_navigation_screen.dart';
import '../../bloc/UserInformation/user_information_cubit.dart';

class LoginVerificationScreen extends StatefulWidget {
  final fullNumber, verifyCode, phoneNumber, dialCode;
  const LoginVerificationScreen(
      {Key? key,
      this.fullNumber,
      this.verifyCode,
      this.phoneNumber,
      this.dialCode})
      : super(key: key);

  @override
  State<LoginVerificationScreen> createState() =>
      _LoginVerificationScreenState();
}

class _LoginVerificationScreenState extends State<LoginVerificationScreen> {
  int _start = 30;
  late Timer _timer;
  String start = "30";
  List<Service> serviceList = <Service>[];
  bool resendButtonisEnable = false;
  PhoneAuthController controller = PhoneAuthController();
  bool isLoading = false;

  final storage = const FlutterSecureStorage();
  late String otp;
  Future<void> getOTP() async => otp = await storage.read(key: 'otp') ?? '';
  final TextEditingController pin = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode pinNode = FocusNode();

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
    getOTP();
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
      body: Stack(
        children: [
          const CustomAppBar(title: "تفعيل التطبيق"),
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
                                "الرجاء إدخال رمز التحقق الخاص بالرقم",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: myprimercolor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          // OTP form
                          PinForm(
                            onSubmit: () => _submit(),
                            focusNode: pinNode,
                            pin: pin,
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
                              "إعادة إرسال رمز التحقق",
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
                              height: 50,
                              child: BlocBuilder<UserInformationCubit,
                                  UserInformationState>(
                                builder: (context, state) {
                                  return TextButton(
                                    child: Text(
                                      'تأكيد',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    style: bs_flatFill(context, myprimercolor),
                                    onPressed: () => _submit(),
                                  );
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
          if (isLoading)
            Positioned(
              left: 0,
              top: 80,
              right: 0,
              bottom: 0,
              child: Center(child: CircularProgressIndicator()
                  // child: Text("Hello")
                  ),
            )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (pin.text != otp) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid OTP code')));
      return;
    }

    User user = User();
    setState(() => isLoading = true);
    // var mobile = widget.fullNumber
    //     ?.replaceFirst("+", "");
    //
    // var token = await user.login(
    //     mobile: mobile);

    var token = await user.login(mobile: widget.fullNumber);

    // store token
    if (token != "") {
      // for write
      await storage.write(key: 'token', value: token); // Save token
      // get user Info
      var userInfo = await user.getUser(mobile: widget.fullNumber);
      BlocProvider.of<UserInformationCubit>(context).addProfile(userInfo!);
      // profileCubit.addProfile(userInfo!);
      //print( context.read<UserInformationCubit>().state.fetchedPerson?.id);

      //#region firbase notification token
      try {
        // if(Platform.isAndroid){
        final String? firbasetoken =
            await FirebaseMessaging.instance.getToken();
        debugPrint(firbasetoken);
        // }

        globalUser.saveToken(clientId: userInfo.id!, token: firbasetoken!);
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
        ));
      }

      //#endregion

      setState(() => isLoading = false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainNavigationScreen()),
          (route) => route.settings.name == '/mainNavigation');
    } else {
      // for write mobile phone
      await storage.write(key: 'mobile', value: widget.phoneNumber);
      await storage.write(key: 'dialCode', value: widget.dialCode);
      // await storage.write(
      //     key: 'mobile', value: widget.fullNumber);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Register(),
      ));
    }
  }
}
