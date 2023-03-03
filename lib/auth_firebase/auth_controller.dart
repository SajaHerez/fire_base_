import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AuthController {
  FirebaseAuth auth = FirebaseAuth.instance;
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
      user = creUser.user;
      user?.updateDisplayName(name);
      user?.reload();
      user = auth.currentUser;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
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

  logout() async{
   await auth.signOut();
  }
}
