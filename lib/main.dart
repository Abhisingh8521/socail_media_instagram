import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kriscent_assignment/views/screens/auth/auth_screen.dart';
import 'package:kriscent_assignment/views/screens/landing/landing_screen.dart';
import 'package:kriscent_assignment/views/screens/profile/profile_screen.dart';
import 'package:kriscent_assignment/views/screens/splash/splash_screen.dart';
import 'views/screens/profile/update_profile_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
