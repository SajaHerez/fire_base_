import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailandLink(userEmail) async {
    var _userEmail = userEmail;
    return await _auth
        .sendSignInLinkToEmail(
            email: _userEmail,
            actionCodeSettings: ActionCodeSettings(
              url: "https://crnn.page.link/iDzQ",
              handleCodeInApp: true,
              androidPackageName: "com.example.fire_base_",
              androidMinimumVersion: "1",
            ))
        .then((value) {
      print("email sent");
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("in 111side didChangeAppLifecycleState>>>>>>>>>>>>>>>>>>>>>>> ");
    print(
        "in 12222222211side didChangeAppLifecycleState>>>>>>>>>>>>>>>>>>>>>>> ");

    try {
      FirebaseDynamicLinks.instance.onLink.listen(
          (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;
        if (deepLink != null) {
          print("the first::::: ${dynamicLink?.link.toString()}");
          handleLink(deepLink, _emailController.text);
          FirebaseDynamicLinks.instance.onLink.listen(
              (PendingDynamicLinkData? dynamicLink) async {
            final Uri deepLink = dynamicLink!.link;
            print("the sconde ::::${deepLink.toString()}");

            handleLink(deepLink, _emailController.text);
          }, onError: (e) async {
            print(" the first ::::::${e.message}");
          });
          // Navigator.pushNamed(context, deepLink.path);
        }
      }, onError: (e) async {
        print(" the second ::::::${e.message}");
      });

      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        print(deepLink.userInfo);
      }
    } catch (e) {
      print(e);
    }
  }

  void handleLink(Uri link, userEmail) async {
    print(
        'inside handle Link $userEmail >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    try {
      // final UserCredential user =
      //     await FirebaseAuth.instance.signInWithEmailLink(
      //   email: userEmail,
      //   emailLink: link.toString(),
      // );
      final authCredential = EmailAuthProvider.credentialWithLink(
          email: userEmail, emailLink: link.toString());
      print("auth  Credential ::::::::::::::$authCredential");
      try {
        final userCredential = await FirebaseAuth.instance.currentUser
            ?.linkWithCredential(authCredential);
        print("the email??????????????????????????????????? ");
        print(userCredential?.user!.email);
        print("user Credential ::::::::::::::$userCredential");
      } catch (error) {
        print("Error linking emailLink credential.");
      }
      // print(user.credential);
      // print("the user :::::::::::::${user.user}");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Type in your email address",
                  fillColor: Colors.white70),
              controller: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {
                signInWithEmailandLink(_emailController.text);
              },
              color: Colors.blue,
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
