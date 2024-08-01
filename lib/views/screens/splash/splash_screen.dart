import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/auth/auth_controller.dart';
import 'package:kriscent_assignment/views/screens/landing/landing_screen.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    Future.delayed(const Duration(seconds: 3), () {
      if (AuthController().isLogin() == false) {
        context.gotoNextNeverBack(page: LoginScreen());
      } else {
        context.gotoNextNeverBack(page: LandingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: Image(image: AssetImage('assets/logo/insta_text_logo.png')))],
      ),
    );
  }
}
