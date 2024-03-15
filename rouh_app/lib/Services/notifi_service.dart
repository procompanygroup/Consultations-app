import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
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
      (int id, String? title, String? body, String? payload) async {});

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

      //
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute<void>(builder: (context) =>
      //       SecondScreen(payload)),);
    }
  }
}
