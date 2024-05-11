import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../bloc/expert/expert_information_cubit.dart';
import '../components/view_image_screen.dart';
import '../components/view_text_screen.dart';
import '../components/view_video_screen.dart';
import '../screens/experts/expert_info_screen.dart';
import '../screens/orders/order_info_screen.dart';
import 'globalController.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();


  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = 
        const AndroidInitializationSettings('logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
      (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      });

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    // await notificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);

    // await notificationsPlugin.initialize(initializationSettings,
    // onDidReceiveNotificationResponse:
    // (NotificationResponse notificationResponse) async {});

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
              notificationResponseFunction(notificationResponse);
            });

  }

    notificationDetails() {
      return const NotificationDetails(
        android: AndroidNotificationDetails('NotificationChannelId', 'NotificationChannelName',
        importance: Importance.max,
            channelShowBadge:true,
            enableVibration: true,
            playSound: true),
        iOS: DarwinNotificationDetails());
    }

    Future showNotification({int id=0, String? title, String? body, String? payload}) async {
          // await initNotification();
          return notificationsPlugin.show(id, title, body, await notificationDetails(),payload: payload);
    }



  Future notificationResponseFunction(NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      print('notification payload: ' + notificationResponse.id!.toString());
      print('notification payload: ' + notificationResponse.payload!);


      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == '0') {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }

      //
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(builder: (context) =>
      //       SecondScreen(payload)),);
    }
  }



  Future<void> NotificationForwardPage(String? payload, BuildContext context)
  async {

    try{



      int id = int.parse(payload!);
     var notification = await globalNotification.GetNotifyById(id: id);


      try {
        print(notification!.isRead!);
        if (!notification.isRead!) {
          globalNotification.SetToRead(id: notification.id!);

        }
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
        ));
      }
      try {
        print(notification!.type!);
        if (notification.type! == 'text') {
          await  Navigator.of( context).push(
            MaterialPageRoute(
                builder: (context) => ViewTextScreen(
                  text: notification.body!,
                )),
          );
        }
        else if (notification.type! == 'image') {
          await Navigator.of( context).push(
            MaterialPageRoute(
                builder: (context) => ViewImageScreen(
                  imagePath: notification.path!,
                )),
          );
        }
        else if (notification.type! == 'video') {
          await   Navigator.of( context).push(
            MaterialPageRoute(
                builder: (context) => ViewVideoScreen(
                  videoPath: notification.path!,
                )),
          );
        }
        else if (notification.type! == 'order') {
          print('notification.type!');
          print(notification.type!);
          print(notification.orderType!);
          if (notification.orderType! == 'comment') {

            late int expertId;
            expertId = context.read<ExpertInformationCubit>().state.fetchedExpert!.id!;

            print("start GetExpertWithComments");
            print(expertId);
            var expertInfo =  await globalExpert.GetExpertWithComments(expertId: expertId);
            print("expertInfo != null:");
            print((expertInfo != null).toString());


            if(expertInfo != null)
            {
              await   Navigator.of( context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ExpertInfo(expert: expertInfo),
                ),
              );
            }
          }
          else if ( notification.orderType! == 'answer-agree' ) {
            await  Navigator.of( context).push(
              MaterialPageRoute(
                  builder: (context) => ViewTextScreen(
                    text: notification.body!,
                  )),
            );
          }
          else if ( notification.orderType! == 'answer-reject'|| notification.orderType! == 'answer-wait')
          {


            var resultOrder = await globalExpertOrder.GetOrderById(selectedServiceId: notification.selectedServiceId!);


            if(resultOrder != null)
            {
              if(resultOrder.answerState != "agree")
              {

                var answerRecordPath = "";
                if(resultOrder.answerState == "wait")
                {
                  var  expertAnswer= await globalExpertOrder.GetAnswer(selectedServiceId:   resultOrder.selectedServiceId!);
                  answerRecordPath = expertAnswer.recordPath!;
                }
                await  Navigator.of( context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderInfoScreen(expertOrder: resultOrder, answerRecordPath:answerRecordPath ),
                  ),
                );
              }
              else
              {
                await  Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => ViewTextScreen(
                        text: notification.body!,
                      )),
                );
              }


            }


          }
        }
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
        ));
      }


    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err.toString()),
          )
      );
    }
  }
}




/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();



class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}


/*
class SecondPage extends StatelessWidget {
  const SecondPage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Placeholder(
      child: Center(
        child: Text(title),
      ),
    );
  }
}
*/

