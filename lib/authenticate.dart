import 'package:flutter/cupertino.dart';
import 'package:library_app/screens/sign_in_screen.dart';
import 'package:library_app/screens/sign_up_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleAuth() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignInScreen(toggleAuth: toggleAuth)
        : SignUpScreen(toggleAuth: toggleAuth);
  }
}
