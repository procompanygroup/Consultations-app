import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../components/view_image_screen.dart';
import '../components/view_text_screen.dart';
import '../components/view_video_screen.dart';
import '../screens/notifications/replied_message_screen.dart';
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

      // await Navigator.of(context).push(
      //   MaterialPageRoute<void>(
      //     builder: (BuildContext context) =>
      //         SecondPage(title:  receivedNotification.payload!),
      //   ),
      // );

      int id = int.parse(payload!);
     var notification = await globalNotification.GetNotifyById(id: id);

      try {
        print(notification!.isRead!);
        if (!notification.isRead!)
        {
          globalNotification.SetToRead(id: notification.id!);
        }
      } catch (err) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err.toString()),
            )
        );
      }
      try {

        print(notification!.type!);
        if (notification.type! == 'text') {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ViewTextScreen(text: notification.body!,)
            ),
          );
        }
        else if (notification.type! == 'image') {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ViewImageScreen(imagePath: notification.path!,)
            ),
          );
        }
        else if (notification.type! == 'video') {
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    ViewVideoScreen(videoPath: notification.path!,)
            ),
          );
        }
        else if (notification.type! == 'order')
        {

          var resultOrder = await globalOrder.GetOrderWithAnswer(selectedServiceId: notification!.selectedServiceId!);
          // var resultOrder = await globalOrder.GetOrderWithAnswer(selectedServiceId: 70);


          print("resultOrder != null");
          print(resultOrder != null);
          if(resultOrder != null)
          {
            print("resultOrder");
            print(resultOrder);
            print(resultOrder.client_id);
            print('resultOrder.selectedServiceId');
            print(resultOrder.selectedServiceId);

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) =>
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

