import 'dart:ui';

import 'package:fire_base_/auth_firebase/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Sign in to your Firebase account',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(label: Text('Email')),
          controller: email,
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(label: Text('Password')),
          controller: password,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () async {
              final user=await authController.Login(
                  email: email.text, password: password.text, context: context);
            },
            child: const Text('login')),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => SignUpPage())));
          },
          child: const Text("click here to Sign Up!!"),
        )
      ]),
    );
  }
}
