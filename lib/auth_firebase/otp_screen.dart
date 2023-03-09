import 'package:fire_base_/auth_firebase/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth_controller.dart';
import 'email_page.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({super.key, required this.verificationId});
  final String verificationId;
  TextEditingController otp = TextEditingController();
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
          'Enter OTP Code',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(label: Text('OTP')),
          controller: otp,
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () async {
              await authController.signInWithPhoneNumber(
                  otp.text, verificationId, context);
            },
            child: const Text('send')),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
