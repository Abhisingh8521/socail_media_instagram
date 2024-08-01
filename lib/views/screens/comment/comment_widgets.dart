import 'package:flutter/material.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';


class CommentWidgets {
  BuildContext context;

  CommentWidgets({required this.context});

  Widget commentListView(List<Comment>? comments) {
    var data = comments ?? List<Comment>.empty();
    return data.isNotEmpty
        ? ListView.builder(
      itemCount: data.length,
        itemBuilder: (_, index) {
            return _commentItemView(data[index]);
          })
        : const Center(
            child: Text("No comments found!"),
          );
  }

  Widget _commentItemView(Comment data) {
    return ListTile(
      title: Row(
        children: [
          Text(
            data.comment ?? "NA",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(data.date?.split(" ").last.split(":").first ?? "")
        ],
      ),
      subtitle: Text(data.comment ?? "NA"),
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Text(data.comment!.split("").first),
      ),
    );
  }
}
