import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../auth_firebase/login.dart';

class MessagingService {
  //working when app  in foreground
  static void getMassageOnForeground() {
    FirebaseMessaging.onMessage.listen((message) {
      //handle the message here
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'foreground Message also contained a notification: ${message.notification}');
      }
    });
  }

  // working when app in background  when user clicks on notification
  static void getMassageOnBackground() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //handle the message here
      print('Got a message whilst in the background!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(
            'background Message  also contained a notification: ${message.notification}');
      }
    });
  }

  // working when app in terminted state  when user clicks on notification
  static Future<void> getMassageOnTermintedAndData(context) async {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        if (message != null) {
          String route = message.data['route'];
          if (route == "login") {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
          }
        }
      },
    );
  }

  // working when app in background  when user clicks on notification
  // static Future<void> getMassageOnBackgroundAndData() async {
  //   FirebaseMessaging.onBackgroundMessage(
  //     (message) async{
  // print('Got a message whilst in the background with data !');
  //     print('Message data: ${message.data.toString()}');
  //     if (message.notification != null) {
  //       print(
  //           'background Message  also contained a notification: ${message.notification.toString()}');
  //     }
  //     },
  //   );
  // }
}
