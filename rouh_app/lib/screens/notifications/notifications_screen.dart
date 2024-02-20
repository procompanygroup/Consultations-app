import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../mystyle/constantsColors.dart';
import '../../widgets/custom_appbar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double bodyHeight = (MediaQuery.of(context).size.height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
    );

    String _selectedNotification = "Notification_1";
    List<ClassNotification> notificationList = [
      ClassNotification(
          id: 1,
          title: "Duis aute irure dolor",
          body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          created_at: DateTime.now(),
          isread: true,
      ),

      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: false,
      ),

      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: true,
      ),
      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: true,
      ),

      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: false,
      ),

      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: true,
      ),
      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: true,
      ),

      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: false,
      ),

      ClassNotification(
        id: 1,
        title: "Duis aute irure dolor",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        created_at: DateTime.now(),
        isread: true,
      ),


    ];

    _buildNotifications(List<ClassNotification> notifications) {
      List<Widget> notificationWidgetList = [];


      notifications.forEach((ClassNotification notification) {
        notificationWidgetList.add(
          Column(
            children: [
              Container(
                width: screenWidth - 60 ,
                decoration: BoxDecoration(
                  // border: Border.all(color: mysecondarycolor,width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade50,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 20,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:  EdgeInsetsDirectional.only(start: 25),
                                    child: Text(
                                      "Duis aute irure dolor in reprehenderit" ,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "2022/22/22" ,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Expanded(
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." ,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.circle,
                        size: 15,
                        color: mysecondarycolor,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, top: 5, right: 40, bottom: 5),
                child: Divider(color: Colors.grey.shade300),
              ),
            ],
          ),
        );
      });

      return Column(
        children: notificationWidgetList,
      );
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // top
          const CustomAppBar(title: "Notifications"),
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    // notificationsList
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: _buildNotifications(notificationList)),
                        )),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: _buildServices(serviceList),
                    //   ),
                    // ),


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


class ClassNotification{
 int id;
 String title;
 String body;
 DateTime created_at;
 bool isread;

 ClassNotification({ required this.id, required this.title, required this.body, required this.created_at,required this.isread});
}
