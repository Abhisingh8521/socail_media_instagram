import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/auth/auth_controller.dart';
import 'package:kriscent_assignment/controllers/profile/profile_controller.dart';
import 'package:kriscent_assignment/models/users/user_model.dart';
import 'package:kriscent_assignment/views/screens/auth/login_screen.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/int_extensions.dart';

import 'my_reels_screen.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: ProfileController().getUserProfile(),
          builder: (_, snap) {
            if (!snap.hasData) {
              return Container();
            } else {
              var data = snap.data?.data();
              var user = UserModel.fromJson(data ?? Map());
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        user.name ?? "NA",
                        style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconButton(
                            onPressed: () async {
                              _showAlertDialog(context);
                            },
                            icon: Icon(Icons.logout)),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: user.imageUrl == null
                                    ? Icon(Icons.person)
                                    : CircleAvatar(
                                  radius: 40,
                                        backgroundImage:
                                            NetworkImage(user.imageUrl ?? ""),
                                      ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildStatColumn(
                                            "${user.posts?.length ?? 0}",
                                            "Posts"),
                                        _buildStatColumn(
                                            "${user.followers?.length ?? 0}",
                                            "Followers"),
                                        _buildStatColumn(
                                            "${user.followings?.length ?? 0}",
                                            "Following"),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            user.name ?? "NA",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user.bio ?? "NA",
                          ),
                          10.height,
                          ElevatedButton(
                            onPressed: () {
                              context.gotoNext(page: UpdateProfileScreen());
                            },
                            child: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              // onPrimary: Colors.black,
                              minimumSize: Size(double.infinity, 30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MyReelsScreen()
                ],
              );
            }
          }),
    );
  }

  Column _buildStatColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
        ),
      ],
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You want to logout'),
          content: Text('Your app is close'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                AuthController().logoutUser().then((_) {
                  context.gotoNextNeverBack(page: LoginScreen());
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
