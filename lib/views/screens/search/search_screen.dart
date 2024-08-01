import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/reel/reel_controller.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';
import 'package:kriscent_assignment/views/screens/video/network_video_player_screen.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/widgets/custom_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ReelModel> videos = <ReelModel>[];

  searchReel(String text) async {
    var data = await ReelController().searchReels(text);
    var items = data.docs;
    var _videos =
        items.map((video) => ReelModel.fromJson(video.data())).toList();
    videos.clear();
    videos = _videos;
    setState(() {});
  }

  @override
  void initState() {
    searchReel("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(context.fullWidth, 65),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomWidgets.customTextFiled(searchController,
                prefixIcon: const Icon(Icons.search_outlined),
                hintText: "Search here...", onChanged: (text) async {
              searchReel(text);
              setState(() {});
            }),
          ),
        ),
        body: videos.isNotEmpty
            ? GridView.builder(
                itemCount: videos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 2,
                    crossAxisCount: 3,
                    childAspectRatio: .5),
                itemBuilder: (_, index) {
                  return NetworkVideoPlayerScreen(
                      videoUrl: videos[index].reelUrl.toString());
                })
            : Center(
                child: Text("No reel found!"),
              ),
      ),
    );
  }
}
