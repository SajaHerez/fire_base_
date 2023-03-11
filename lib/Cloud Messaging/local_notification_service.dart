import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();
//initialize local notification// channel to show headup notifications
  static void initialize() {
    InitializationSettings setting = const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _localNotification.initialize(setting);
  }

  static void showHeadupNotifications(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails details = const NotificationDetails(
          android: AndroidNotificationDetails(
        "easyapp",
        "Notification Channel",
        channelDescription: "Hi ,This is our channel",
        importance: Importance.max,
        priority: Priority.high,
      ));
    await  _localNotification.show(
          id, message.notification?.title, message.notification?.body, details);
    } catch (e) {
      print(e.toString());
    }
  }
}
