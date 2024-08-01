import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/profile/profile_controller.dart';
import 'package:kriscent_assignment/controllers/reel/reel_controller.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';
import 'package:kriscent_assignment/models/users/user_model.dart';
import 'package:kriscent_assignment/views/screens/reels/comment_like_view.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:video_player/video_player.dart';
import '../../../widgets/custom_button.dart';
import '../video/video_screen.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final List<String> videoUrls = [];
  var reels = <ReelModel>[];

  final PageController _pageController = PageController();
  late VideoPlayerController _videoPlayerController;
  var currentId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    getReels();
  }

  getReels() async {
    var data = await ReelController().getAllReels();
    var items =
        data.docs.map((reel) => ReelModel.fromJson(reel.data())).toList();
    for (var reel in items) {
      videoUrls.add(reel.reelUrl ?? "");
      reels.add(reel);
      // _initializeVideoPlayer(reel.reelUrl ?? "");
    }
    setState(() {});
    if (videoUrls.isNotEmpty) _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrls[0]))
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController.play();
            _videoPlayerController.setLooping(true);
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels'),
      ),
      body: videoUrls.isNotEmpty
          ? PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                return reelsItem(
                  index,
                  videoUrl: videoUrls[index],
                  onVideoReady: () {
                    if (_videoPlayerController.value.isInitialized) {
                      _videoPlayerController.pause();
                    }
                    _videoPlayerController = VideoPlayerController.networkUrl(
                        Uri.parse(videoUrls[index]))
                      ..initialize().then((_) {
                        setState(() {});
                        _videoPlayerController.play();
                      });
                  },
                );
              },
              onPageChanged: (index) {
                // _initializeVideoPlayer(videoUrls[index]);
              },
            )
          : Center(
              child: Center(
                child: Text("No reels found!"),
              ),
            ),
    );
  }

  Widget reelsItem(int index,
      {required String videoUrl, required VoidCallback onVideoReady}) {
    return Container(
      height: context.fullHeight,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[400],
      ),
      child: Stack(
        children: [
          VideoPlayerScreen(
            videoUrl: videoUrl,
            onVideoReady: onVideoReady,
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: reels[index].postBy == currentId
                ? _currentUserprofileView()
                : _otherUserprofileView(reels[index]),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: CommentLikeView(
              reelId: reels[index].id.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _currentUserprofileView() {
    var currentId = FirebaseAuth.instance.currentUser?.uid;
    return FutureBuilder(
        future: ProfileController().getUser(currentId.toString()),
        builder: (_, snap) {
          if (!snap.hasData) {
            return Container();
          } else {
            var user = snap.data ?? UserModel();
            return Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: user.imageUrl == null
                      ? Icon(Icons.person)
                      : CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    NetworkImage(user.imageUrl ?? ""),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "${user.name} (You)",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(width: 10)
              ],
            );
          }
        });
  }

  var isFollowing = true;

  Widget _otherUserprofileView(ReelModel reel) {
    return FutureBuilder(
        future: ProfileController().getUser(reel.postBy ?? ""),
        builder: (_, snap) {
          if (!snap.hasData) {
            return Container();
          } else {
            var user = snap.data ?? UserModel();
            return StreamBuilder(
                stream: ReelController().getReel(reel.id ?? ""),
                builder: (_, snap) {
                  if (!snap.hasData) {
                    return Container();
                  } else {
                    var data = snap.data?.data();
                    var reel = ReelModel.fromJson(data ?? Map());
                    var id = FirebaseAuth.instance.currentUser?.uid;
                    if (reel.likes != null) {
                      isFollowing = reel.followings!
                          .where((likedId) => likedId == id)
                          .isNotEmpty;
                    }
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Text(user.name.toString().split("").first),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          user.name.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        CustomButton(
                          text: isFollowing == true ? "Follow" : "Following",
                          onPressed: () async {
                            var id = FirebaseAuth.instance.currentUser?.uid;
                            await ReelController().followUser(
                                reel.id.toString(), id.toString(), isFollowing);
                            await ProfileController()
                                .followUser(id.toString(), isFollowing);
                          },
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    );
                  }
                });
          }
        });
  }
}
