import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential creUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = creUser.user;
      user?.updateDisplayName(name);
      user?.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      print(e.message);
    }

    return user;
  }

   Future<User?> loginUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential creUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = creUser.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
    return user;
  }

   Future<User?> refreshUser(User user) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await user.reload();
  User? refreshedUser = auth.currentUser;

  return refreshedUser;
}
}
