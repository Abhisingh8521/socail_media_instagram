import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/reel/reel_controller.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';
import 'package:kriscent_assignment/views/screens/video/network_video_player_screen.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/widgets/custom_widget.dart';

class MyReelsScreen extends StatefulWidget {
  const MyReelsScreen({super.key});

  @override
  State<MyReelsScreen> createState() => _MyReelsScreenState();
}

class _MyReelsScreenState extends State<MyReelsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ReelModel> videos = <ReelModel>[];

  searchReel() async {
    var data = await ReelController().getMyReels();
    var items = data.docs;
    var _videos =
    items.map((video) => ReelModel.fromJson(video.data())).toList();
    videos.clear();
    videos = _videos;
    setState(() {});
  }

  @override
  void initState() {
    searchReel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return videos.isNotEmpty
        ? SliverGrid.builder(
        itemCount: videos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 2,
            crossAxisCount: 3,
            childAspectRatio: .5),
        itemBuilder: (_, index) {
          return NetworkVideoPlayerScreen(
              videoUrl: videos[index].reelUrl.toString());
        })
        : SliverGrid.builder(
      itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 2,
        crossAxisCount: 3,
        childAspectRatio: .5), itemBuilder: (_,index){
          return Container();
    });
  }
}
