import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

class NotifyHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    tz.initializeTimeZones();

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android:initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);
  }


  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  scheduledNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Görev vakti',
        'Tema 5 saniye önce değişti',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name',)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

  }


  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("No plaload");
    }

    if(payload=="Theme Changed"){
    }else{
      Get.to(()=> Container(color: Colors.white,));
    }
  }

}
