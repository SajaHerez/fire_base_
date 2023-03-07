import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

class AuthController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Timer? timer;
  Future<User?> register({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    User? user;
    try {
      final creUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (!auth.currentUser!.emailVerified) {
        await emailVerfication(email);
      }

      user = creUser.user;
      user?.updateDisplayName(name);
      user?.reload();
      user = auth.currentUser;
      if (auth.currentUser!.emailVerified) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const HomeScreen())));
      } else {
        print('email is not Verified');
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          print("Anonymous accounts are not enabled");
          break;
        case "ERROR_WEAK_PASSWORD":
          print("Your password is too weak");
          break;
        case "ERROR_INVALID_EMAIL":
          print("Your email is invalid");
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          print("Email is already in use on different account");
          break;
        case "ERROR_INVALID_CREDENTIAL":
          print("Your email is invalid");
          break;

        default:
          print("An undefined Error happened.");
      }
    }
    return user;
  }

  Future<User?> Login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    User? user;
    try {
      final creUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = creUser.user;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          print("Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          print("Your password is wrong.");
          break;
        case "ERROR_USER_NOT_FOUND":
          print("User with this email doesn't exist.");
          break;
        case "ERROR_USER_DISABLED":
          print("User with this email has been disabled.");
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          print("Too many requests. Try again later.");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          print("Signing in with Email and Password is not enabled.");
          break;
        default:
          print("An undefined Error happened.");
      }
    }
    return user;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> emailVerfication(String email) async {
    await auth.currentUser?.sendEmailVerification();
    Timer.periodic(Duration(seconds: 3), (_) => checkEmailValidity());
  }

  Future<bool> checkEmailValidity() async {
    await auth.currentUser?.reload();
    bool isEmailV = auth.currentUser?.emailVerified ?? false;
    if (isEmailV) {
      timer?.cancel();
    }
    return isEmailV;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInWithEmailAndLink(String email) async {
    return await auth
        .sendSignInLinkToEmail(
            email: email,
            actionCodeSettings: ActionCodeSettings(
              url: "https://crnn.page.link/",
              handleCodeInApp: true,
              androidPackageName: "com.example.fire_base_",
              androidMinimumVersion: "1",
            ))
        .then((value) {
      print("email sent");
    });
  }

  Future<void> getInitialLink(String email, context) async {
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (data?.link != null) {
        handleLink(data?.link, email, context);
        print(
            'here getInitialLink function  ::::::::::::::::::::::::::::::::::::::::::::::::::::');
        print(
            'here getInitialLink function  ::::::::::::::::::::::::::::::::::::::::::::::::::::');
        print(
            'here getInitialLink function  ::::::::::::::::::::::::::::::::::::::::::::::::::::');
      }
      Stream<PendingDynamicLinkData> stream =
          FirebaseDynamicLinks.instance.onLink;
      stream.listen((dynamicLink) {
        final Uri deepLink = dynamicLink.link;
        handleLink(deepLink, email, context);
        print(
            'here getInitialLink function ===========================================:');
        print(
            'here getInitialLink function  =============================================');
        print(
            'here getInitialLink function  ===============================================:');
      }, onError: (error) {
        print('onLinkError');
        print(error.message);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleLink(Uri? link, userEmail, context) async {
    print(
        'here handleLink function  ******************************************');
    print(
        'herehandleLink function  **********************************************:');
    if (link != null) {
      print(userEmail);
      final UserCredential user =
          await FirebaseAuth.instance.signInWithEmailLink(
        email: userEmail,
        emailLink: link.toString(),
      );
      if (user.credential != null) {
        print(
            'herehandleLink function  before navigation **********************************************:');
        print(user.credential!.signInMethod);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const HomeScreen())));
        print(
            'herehandleLink function  after navigation **********************************************:');
      }
    } else {
      print("link is null");
    }
  }
}
