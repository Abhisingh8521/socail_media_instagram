import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kriscent_assignment/views/screens/auth/login_screen.dart';
import 'package:kriscent_assignment/views/screens/auth/signup_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo/insta_text_logo.png', width: 200, height: 100),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/user_avatar.png'), // Add your user's avatar image here
              ),
              const SizedBox(height: 10),
              const Text(
                'jacob_w',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your login logic here
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
                },
                child: const Text('Log in'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  // onPrimary: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 10),
              // GestureDetector(
              //   onTap: () {
              //     // Add logic to switch accounts here
              //   },
              //   child: Text(
              //     'Switch accounts',
              //     style: TextStyle(color: Colors.blue),
              //   ),
              // ),
              const SizedBox(height: 30),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    // Add your sign up logic here
                  },
                  child: RichText(
                    text:  TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(context,MaterialPageRoute(builder: (_)=>SignUpScreen())),
                          text: 'Sign up.',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
