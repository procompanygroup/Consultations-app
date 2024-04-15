import 'package:flutter/material.dart';

import '../../mystyle/constantsColors.dart';
import '../../components/custom_appbar.dart';

class NotificationTextScreen extends StatefulWidget {
  const NotificationTextScreen({super.key});

  @override
  State<NotificationTextScreen> createState() => _NotificationTextScreenState();
}

class _NotificationTextScreenState extends State<NotificationTextScreen> {
  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double bodyHeight = (MediaQuery.of(context).size.height //screen
          // - MediaQuery.of(context).padding.top // safe area
          // - AppBar().preferredSize.height //AppBar
      );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // top
          const CustomAppBar(title: "Notification"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                border: Border.all(color: Colors.grey),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                          ,style: TextStyle(
                            fontSize: 16,
                            color: myprimercolor,
                          // fontWeight: FontWeight.bold
                        ),
                                            ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
