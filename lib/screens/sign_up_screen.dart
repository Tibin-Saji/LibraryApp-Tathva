import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.toggleAuth}) : super(key: key);
  final Function toggleAuth;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String c_password = '';
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
                TextMedium('Welcome to'),
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
                //Password
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
                const SizedBox(
                  height: 20,
                ),

                //Confirm Password
                TextFormField(
                  validator: (value) =>
                      value != password ? 'Your passwords do not match' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      labelText: 'Confirm Password',
                      hintText: 'Enter Your Password'),
                  onChanged: (value) {
                    setState(() {
                      c_password = value;
                    });
                    // if (c_password != password) {
                    //   setState(() {
                    //     passwordMatch = false;
                    //   });
                    // }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextSmall('Already a member?'),
                    TextButton(
                      onPressed: () {
                        widget.toggleAuth();
                      },
                      child: const Text('Sign In'),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        var result = await _auth.registerWithEmailPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            error = "Invalid Email";
                          });
                        }
                      }
                    },
                    child: TextMedium('Sign Up'),
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
