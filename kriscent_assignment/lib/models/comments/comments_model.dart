// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  String? userImage;
  String? comment;
  String? userName;
  String? date;
  String? id;
  String? commentBy;

  CommentModel({
    this.userImage,
    this.comment,
    this.userName,
    this.date,
    this.id,
    this.commentBy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    userImage: json["userImage"],
    comment: json["comment"],
    userName: json["userName"],
    date: json["date"],
    id: json["id"],
    commentBy: json["commentBy"],
  );

  Map<String, dynamic> toJson() => {
    "userImage": userImage,
    "comment": comment,
    "userName": userName,
    "date": date,
    "id": id,
    "commentBy": commentBy,
  };
}
