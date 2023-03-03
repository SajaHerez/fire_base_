import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          'SignUp to your Firebase account',
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
          controller: email,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: () {}, child: const Text('login')),
        const SizedBox(
          height: 30,
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
