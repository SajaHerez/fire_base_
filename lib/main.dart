import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Cloud Messaging/local_notification_service.dart';
import 'Cloud Messaging/messaging_service.dart';
import 'auth_firebase/home_test.dart';
import 'auth_firebase/login_test.dart';
import 'auth_firebase/sign_up_screen.dart';
import 'ex1/my_home.dart';
import 'ex2/config_screen.dart';
import 'firebase_options.dart';

Future<void> getMassageOnBackgroundAndData(RemoteMessage message) async {
  print('Got a message whilst in the background with data !');
  print('Message data: ${message.data.toString()}');
  if (message.notification != null) {
    print(
        'background Message  also contained a notification: ${message.notification.toString()}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(getMassageOnBackgroundAndData);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.instance.getInitialMessage();

// NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );

//print('User granted permission: ${settings.authorizationStatus}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MessagingService.getMassageOnBackground();
    MessagingService.getMassageOnForeground();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
          // primarySwatch: Colors.blue,
          ),
      home: SignUpPage(),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Passwordless Sign in',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             return const HomeScreen();
//           } else {
//             return const LoginPage();
//           }
//         },
//       ),
//     );
//   }
// }
