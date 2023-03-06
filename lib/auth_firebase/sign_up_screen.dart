import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth_controller.dart';
import 'home_screen.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 35,
        ),
        const Text(
          'SignUp to your Firebase account',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(label: Text('UserName')),
          controller: name,
        ),
        const SizedBox(
          height: 18,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(label: Text('Email')),
          controller: email,
        ),
        const SizedBox(
          height: 18,
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
              final user = await authController.register(
                  name: name.text,
                  email: email.text,
                  password: password.text,
                  context: context);
            },
            child: const Text('SignUp')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              final user = await authController.signInWithGoogle();
              print(user);
              Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
            },
            child: const Text('Sign In With Google Account')),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text("click here to Sign In!!"),
        )
      ]),
    );
  }
}
