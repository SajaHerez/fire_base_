// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// class FirebaseHandler {
//   FirebaseHandler(){
//     _auth = FirebaseAuth.instance;
//     initialiseFirebaseOnlink(_deepLinkBackground);
//   }

//  late  FirebaseAuth _auth;
//  late Future<dynamic> _deepLinkBackground;

//   Future getDynamiClikData() async{
//     //Returns the deep linked data
//     final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
//     return data?.link;
//   }

//   Future getDynamiBGData(){
//     //Returns the deep linked data
//     return _deepLinkBackground ?? Future((){
//       return false;
//     });
//   }

//   sendEmail({email}){
//     _auth.i.sendSignInWithEmailLink(
//       email: email,
//       url: Constants.firebaseURL,
//       handleCodeInApp: true,
//       androidPackageName: Constants.androidPackageName,
//       iOSBundleID: '',
//       androidInstallIfNotAvailable: true,
//       androidMinimumVersion: '21',
//     );
//   }

//   initialiseFirebaseOnlink(_deepLinkBackground){
//     FirebaseDynamicLinks.instance.onLink(
//       onSuccess: (PendingDynamicLinkData dynamicLink) async {
//         final Uri deepLink = dynamicLink?.link;

//         if (deepLink != null) {
//           _deepLinkBackground = Future((){
//             return deepLink;
//           });
//         }
//       },
//       onError: (OnLinkErrorException e) async {
//         print('onLinkError');
//         print(e.message);
//       }
//     );
//   }
// }