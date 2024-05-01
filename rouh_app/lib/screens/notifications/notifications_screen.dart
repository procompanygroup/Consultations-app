import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/view_image_screen.dart';
import '../../components/view_text_screen.dart';
import '../../components/view_video_screen.dart';
import '../../models/notification_model.dart';
import '../../bloc/UserInformation/user_information_cubit.dart';
import '../../components/show_dialog.dart';
import '../../controllers/globalController.dart';
import '../../mystyle/constantsColors.dart';
import '../../components/custom_appbar.dart';
import 'replied_message_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isLoadingNotifications = true;
  bool isLoadingOrderInfo = false;
  late int clientId;

  List<NotificationModel> notificationList = <NotificationModel>[];

  @override
  void initState() {
    // TODO: implement initState

    clientId = context
        .read<UserInformationCubit>()
        .state
        .fetchedPerson!
        .id!;
    fillNotificationListAsync();
    print(clientId);

    super.initState();
  }

  Future<void> fillNotificationListAsync() async {
    var response = await globalNotification.GetNotifylist(clientId: clientId);
    setState(() {
      notificationList = response;
      isLoadingNotifications = false;
    });
    // notificationList.forEach((element) {
    //   print(element.title.toString() + " - " + element.createdAt.toString() + " - " + element.body.toString()+ " - " + element.isRead.toString());
    //
    // });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double bodyHeight = (MediaQuery
        .of(context)
        .size
        .height //screen
        // - MediaQuery.of(context).padding.top // safe area
        // - AppBar().preferredSize.height //AppBar
    );

    String _selectedNotification = "Notification_1";
    /*
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
*/
    _buildNotifications(List<NotificationModel> notifications) {
      List<Widget> notificationWidgetList = [];


      notifications.forEach((NotificationModel notification) {
        notificationWidgetList.add(
          GestureDetector(
            onTap: () async {

              try {
                print(notification.isRead!);
                if (!notification.isRead!)
                {
                  globalNotification.SetToRead(id: notification.id!);
                setState(() {
                  notification.isRead = true;
                });
                }
              } catch (err) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(err.toString()),
                    )
                );
              }
              try {

                print(notification.type!);
                if (notification.type! == 'text') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewTextScreen(text: notification.body!,)
                    ),
                  );
                }
                else if (notification.type! == 'image') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewImageScreen(imagePath: notification.path!,)
                    ),
                  );
                }
                else if (notification.type! == 'video') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewVideoScreen(videoPath: notification.path!,)
                    ),
                  );
                }
                else if (notification.type! == 'order')
                 {
                    setState(() {
                      isLoadingOrderInfo = true;
                    });

                    var resultOrder = await globalOrder.GetOrderWithAnswer(selectedServiceId: notification.selectedServiceId!);
                    // var resultOrder = await globalOrder.GetOrderWithAnswer(selectedServiceId: 70);


                    setState(() {
                      isLoadingOrderInfo = false;
                    });
                    print("resultOrder != null");
                    print(resultOrder != null);
                    if(resultOrder != null)
                    {
                      print("resultOrder");
                      print(resultOrder);
                      print(resultOrder.client_id);
                      print('resultOrder.selectedServiceId');
                      print(resultOrder.selectedServiceId);

                       Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (context) =>
                               RepliedMessageScreen(order: resultOrder ),
                         ),
                       );
                    }

                }
              } catch (err) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(err.toString()),
                    )
                );
              }

            },
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: screenWidth - 60,
                  decoration: BoxDecoration(
                    // border: Border.all(color: mysecondarycolor,width: 1),
                    borderRadius: BorderRadius.circular(20),
                    color: notification.isRead! ? Colors.white : Colors.grey
                        .shade50,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 5),
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
                                      padding: EdgeInsetsDirectional.only(
                                          start: 25),
                                      child: Text(
                                        notification.title!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: myprimercolor,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    notification.createdAt!.toString().split(
                                        " ")[0],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              height: 40,
                              child: Expanded(
                                child: Container(
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      notification.body!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 3),
                          child: Icon(
                            notification.isRead! ? Icons.circle_outlined
                                : Icons.circle,
                            size: 15,
                            color: mysecondarycolor,
                          ),
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
          const CustomAppBar(title: "سجل التنبيهات"),
          // Body
          Padding(
            padding: EdgeInsets.only(top: bodyHeight * 0.20),
            child: Container(
              width: screenWidth,
              height: bodyHeight * 0.80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
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
          if (isLoadingNotifications || isLoadingOrderInfo)
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

/*
class ClassNotification{
 int id;
 String title;
 String body;
 DateTime created_at;
 bool isread;

 ClassNotification({ required this.id, required this.title, required this.body, required this.created_at,required this.isread});
}
*/