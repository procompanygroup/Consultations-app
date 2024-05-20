import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../mystyle/button_style.dart';
import '../../mystyle/constantsColors.dart';
import 'login_form.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        - MediaQuery.of(context).padding.top // safe area
        - AppBar().preferredSize.height //AppBar
    );

    return Scaffold(
      resizeToAvoidBottomInset:  false,
      body: Column(
        children: [
          // Flexible(
          //   child:
            Stack(
              children: [
                // Top
                Container(
                  height: bodyHeight * 0.60,
                  width: screenWidth,
                  // decoration: BoxDecoration(
                  //   borderRadius:
                  //   BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                  //   color: myprimercolor,
                  //   // border: Border.all(color: Colors.grey)
                  // ),
                  decoration: BoxDecoration(
                      borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                      // border: Border.all(color: Colors.grey),
                    gradient: LinearGradient(
                      colors: [Color(0xff022440),Color(0xff015DAC)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft  ,
                    )
                  ),
                  child: Center(
                    child:
                        /*
                    Image(
                        image: AssetImage("assets/images/logo_background.png"),
                        // height: (bodyHeight * 2 ),
                          width: screenWidth,
                        fit: BoxFit.fitWidth,
                      // color: Color(0xff0d69ff).withOpacity(1.0),
                      // color: Colors.black.withOpacity(0.13),
                      // colorBlendMode: BlendMode.overlay,
                    ),
                    */
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      width: screenWidth,
                      fit: BoxFit.fitWidth,
                      // height: 30,
                      color: Colors.black.withOpacity(0.05),
                      //colorBlendMode: BlendMode.overlay,
                    ),

                  ),
                ),
                Container(
                  height: bodyHeight * 0.60,
                  width: screenWidth,
                  // decoration: BoxDecoration(
                  //   borderRadius:
                  //   BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                  //   color: myprimercolor,
                  //   // border: Border.all(color: Colors.grey)
                  // ),
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                      height: (bodyHeight * 0.60) * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.65,
                //   color:  myprimercolor,
                // ),
                //Bottom
                Padding(
                  padding: EdgeInsets.only( top:  bodyHeight * 0.50),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                          //height: MediaQuery.of(context).size.height * 0.65,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                             border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],

                          ),
                          child:  LoginForm(screenWidth: screenWidth,)),
                  ),
                )
              ],
            ),
          // ),
        ],
      ),
    );
  }
}


