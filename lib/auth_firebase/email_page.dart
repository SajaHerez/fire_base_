import 'package:fire_base_/auth_firebase/home_screen.dart';
import 'package:flutter/material.dart';

import 'auth_controller.dart';

class EmailLinkPage extends StatefulWidget {
  @override
  State<EmailLinkPage> createState() => _EmailLinkPageState();
}

class _EmailLinkPageState extends State<EmailLinkPage>
    with WidgetsBindingObserver {
  TextEditingController email = TextEditingController();

  AuthController authController = AuthController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      authController.getInitialLink(email.text, context);
    }
  }

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
          height: 18,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(label: Text('Email')),
          controller: email,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () async {
              authController.signInWithEmailAndLink(email.text);
            },
            child: const Text('Send')),
      ]),
    );
  }
}
