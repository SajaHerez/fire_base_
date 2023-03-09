
	import 'package:flutter/material.dart';

import 'auth_controller.dart';
import 'login_test.dart';

class HomeScreen extends StatelessWidget {
	  const HomeScreen({Key? key}) : super(key: key);
	

	  @override
	  Widget build(BuildContext context) {
	      return Scaffold(
	        appBar: AppBar(
	          title: const Text("Home Screen"),
	        ),
	        body: Column(
	          children: [
	            const Center(
	              child: Text("You are on home screen"),
               
	            ),
           const    SizedBox(height: 20,)
               ,
              ElevatedButton(
              onPressed: (() async {
                AuthController authController = AuthController();
                await authController.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => LoginPage())));
              }),
              child: const Text("LogOut"))
	          ],
	        ),
	      );
	  }
	}