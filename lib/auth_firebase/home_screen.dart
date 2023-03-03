import 'package:flutter/material.dart';

import 'auth_controller.dart';
import 'login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "wl,it Home Screen",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: (() async {
                AuthController authController = AuthController();
                await authController.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              }),
              child: const Text("LogOut"))
        ],
      )),
    );
  }
}
