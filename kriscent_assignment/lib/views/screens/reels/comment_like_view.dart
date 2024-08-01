import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/reel/reel_controller.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';
import 'package:kriscent_assignment/views/screens/comment/comments_screen.dart';

class CommentLikeView extends StatefulWidget {
  final String reelId;

  const CommentLikeView({super.key, required this.reelId});

  @override
  State<CommentLikeView> createState() => _CommentLikeViewState();
}

class _CommentLikeViewState extends State<CommentLikeView> {
  var isLiked = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ReelController().getReel(widget.reelId),
        builder: (_, snap) {
          if (!snap.hasData) {
            return Container();
          } else {
            var data = snap.data?.data();
            var reel = ReelModel.fromJson(data ?? Map());
            var id = FirebaseAuth.instance.currentUser?.uid;
            if(reel.likes != null){
              isLiked = reel.likes!.where((likedId) => likedId == id).isNotEmpty;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async{
                    var id = FirebaseAuth.instance.currentUser?.uid;
                   if(isLiked == false){
                     await ReelController().makeReelLiked(widget.reelId, id.toString());
                   }else{
                     await ReelController().removeReelLiked(widget.reelId, id.toString());
                   }
                  },
                  icon: isLiked == false
                      ? const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                          size: 30,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return CommentsScreen(
                            reelId: widget.reelId,
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.comment_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            );
          }
        });
  }
}
