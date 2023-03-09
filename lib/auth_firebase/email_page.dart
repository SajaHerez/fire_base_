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
    authController.retrieveDynamicLinkAndSignIn(context, fromColdState: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print(
        '      didChangeAppLifecycleState   11111111      ::::::::::::::::::::::::::::::::::::::::::::::::::::');
    if (state == AppLifecycleState.resumed) {
      print(
          '      didChangeAppLifecycleState  2222222222 inside if       ::::::::::::::::::::::::::::::::::::::::::::::::::::');

      authController.retrieveDynamicLinkAndSignIn(context,
          fromColdState: false);
      print(
          '      didChangeAppLifecycleState  333333333333333333 inside if       ::::::::::::::::::::::::::::::::::::::::::::::::::::');
    }
  }

  @override
  Future<void> onInit() async {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    WidgetsBinding.instance.removeObserver(this);
    super.deactivate();
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
