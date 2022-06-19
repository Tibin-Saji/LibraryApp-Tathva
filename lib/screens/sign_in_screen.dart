import 'package:flutter/material.dart';
import 'package:library_app/services/auth.dart';
import '../widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required this.toggleAuth}) : super(key: key);
  final Function toggleAuth;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 50.0, 18.0, 18.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextMedium('Welcome back to'),
                const Center(
                    child: Text(
                  'NERDY',
                  style: TextStyle(fontSize: 80),
                )),
                const SizedBox(
                  height: 20,
                ),

                // Email Address
                TextFormField(
                  validator: (value) => value == null || value.isEmpty
                      ? 'Email cannot be empty'
                      : null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Email Address',
                      hintText: 'Enter Your Email Address'),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                // Password
                TextFormField(
                  validator: (value) => value == null
                      ? null
                      : value.length < 6
                          ? 'Password must contain minimum 6 characters'
                          : null,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Password',
                      hintText: 'Enter Your Password'),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSmall('Not a member?'),
                    TextButton(
                      onPressed: () {
                        widget.toggleAuth();
                      },
                      child: const Text('Sign Up'),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        var result = await _auth.signInWithEmailPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = "Invalid Email or Password";
                          });
                        }
                      }
                    },
                    child: TextMedium('Sign In'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextCustom(error, color: Colors.red)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
