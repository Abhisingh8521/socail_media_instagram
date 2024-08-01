import 'package:flutter/material.dart';
import 'package:kriscent_assignment/views/screens/profile/profile_screen.dart';
import 'package:kriscent_assignment/views/screens/reels/add_reel_screen.dart';
import 'package:kriscent_assignment/views/screens/reels/reels_screen.dart';
import 'package:kriscent_assignment/views/screens/search/search_screen.dart';


class LandingScreen extends StatefulWidget {
  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentPageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations:  <Widget>[
              NavigationDestination(icon: Image.asset("assets/logo/reel_logo.png",height: 30,), label: 'Reels'),
              NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
              NavigationDestination(icon: Icon(Icons.add_box_outlined), label: 'Post'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
            ],
          ),
          body: <Widget>[
            // Container(),
            ReelsScreen(),
            SearchScreen(),
            AddReelScreen(),
            ProfileScreen(),
          ][currentPageIndex],
        ));
  }
}
