import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/reel/reel_controller.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';
import 'package:kriscent_assignment/views/screens/comment/comment_widgets.dart';
import 'package:kriscent_assignment/views/utils/extensions/int_extensions.dart';
import 'package:kriscent_assignment/widgets/custom_widget.dart';

class CommentsScreen extends StatefulWidget {
  final String reelId;
  const CommentsScreen({super.key, required this.reelId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
   var commentController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var view = CommentWidgets(context: context);
    return Column(
      children: [
        10.height,
        const Text("Comments",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18)),
        const Divider(),
        Expanded(child: StreamBuilder(stream: ReelController().getAllComments(widget.reelId), builder: (_,snap){
          if(!snap.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }else{
            var data = snap.data?.data();
            var reel = ReelModel.fromJson(data??Map());
            var comments = reel.comments;
            return view.commentListView(comments);
          }
        })),
        addCommentView()
      ],
    );
  }

  Widget addCommentView(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(child: CustomWidgets.customTextFiled(commentController,hintText: "Comment..."),),
          10.width,
          CircleAvatar(
            radius: 30,
            child: IconButton(onPressed: ()async{
              var date = DateTime.now().toString();
              var userId = FirebaseAuth.instance.currentUser?.uid;
              var id = DateTime.now().microsecondsSinceEpoch.toString();
              await ReelController().addNewComment(widget.reelId,Comment(
                id: id,
                  comment: commentController.text,
                userId: userId,
                date: date,
                time: "",

              )).then((_){
                commentController.clear();
              });
            }, icon: const Icon(Icons.send)),
          )
        ],
      ),
    );
  }
}
