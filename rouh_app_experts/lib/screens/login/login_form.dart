import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/expert/expert_information_cubit.dart';
import '../../models/country.dart';
import '../../models/expert_model.dart';
import '../../models/user_model.dart';
import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import '../main_navigation_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;
  late String _userName;
  late String _userPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  void _showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(fontSize: 18),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25.0),
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: mysecondarycolor),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10.0),
                  child: Divider(color: Colors.grey.shade300),
                ),

                // user name
                Container(
                  height: 55,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child:TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ) {
                              return '';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _userName = value;
                            // print(serviceValue.value);
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  // width: 2.0,
                                ),
                              ),
                              filled: true,
                              // contentPadding: EdgeInsetsDirectional.only( start: 60, top: 15, end: 15, bottom: 15,),
                              contentPadding: EdgeInsetsDirectional.only(
                                  start: 60, top: 5, end: 10, bottom: 5),
                              hintStyle: TextStyle(color: Colors.grey),
                              // labelText: "Country",
                              hintText: "اسم المستخدم",
                              fillColor: Colors.grey.shade50),

                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        top: 0,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 25,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.account_circle,
                                size: 30,
                                color: Colors.grey.shade300,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: VerticalDivider(
                                  // color: Colors.grey
                                    color: Colors.grey.shade300),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // user password
                Container(
                  height: 55,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child:TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ) {
                              return '';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _userPassword = value;
                            // print(serviceValue.value);
                          },
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                  // width: 2.0,
                                ),
                              ),
                              filled: true,
                              // contentPadding: EdgeInsetsDirectional.only( start: 60, top: 15, end: 15, bottom: 15,),
                              contentPadding: EdgeInsetsDirectional.only(
                                  start: 60, top: 5, end: 10, bottom: 5),
                              hintStyle: TextStyle(color: Colors.grey),
                              // labelText: "Country",
                              hintText: "كلمة المرور",
                              fillColor: Colors.grey.shade50),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        top: 0,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 25,
                          ),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/passcode.svg',
                                width: 30,
                                color: Colors.grey.shade300,
                                fit: BoxFit.fitWidth,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: VerticalDivider(
                                  // color: Colors.grey
                                    color: Colors.grey.shade300),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // login button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<ExpertInformationCubit,ExpertInformationState>(
                    builder:(context,state) {
                      return TextButton(
                          child: Text(
                            'دخول',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: bs_flatFill(context, myprimercolor),
                          // onPressed: () {},
                          onPressed: isLoading
                              ? () {}
                              : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              var expert = Expert();
                              var token = await expert.login(
                                  userName: _userName, password: _userPassword);

                              // store token
                              if (token != "") {
                                const storage = FlutterSecureStorage();
                                // for write
                                await storage.write(
                                    key: 'token',
                                    value: token); // Save token
                                // get user Info
                                var userInfo = await expert.GetExpert(
                                    userName: _userName,
                                    password: _userPassword);
                                BlocProvider.of<ExpertInformationCubit>(
                                    context)
                                    .addProfile(userInfo!);

                                final String? firetoken=await FirebaseMessaging.instance.getToken();
                            debugPrint(firetoken);
                                User userfire = User();
                                userfire.saveToken(expertId: userInfo.id!, token: firetoken!);




                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            MainNavigationScreen()),
                                        (route) =>
                                    route.settings.name ==
                                        '/mainNavigation');
                              }
                              else
                                {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                            }
                          });
                    },
                    ),
                  ),
                ),
              ],
            ),
          ),
          // loading
          if (isLoading)
            Positioned(
              left: 0,
              top: 0,
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
}
