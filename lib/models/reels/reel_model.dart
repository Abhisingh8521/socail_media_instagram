
import 'dart:convert';

ReelModel reelModelFromJson(String str) => ReelModel.fromJson(json.decode(str));

String reelModelToJson(ReelModel data) => json.encode(data.toJson());

class ReelModel {
  String? caption;
  String? createdAt;
  String? id;
  String? postBy;
  String? reelUrl;
  List<Comment>? comments;
  List<String>? likes;
  List<String>? followings;
  List<String>? followers;
  List<String>? searchArray;

  ReelModel({
    this.caption,
    this.createdAt,
    this.id,
    this.postBy,
    this.reelUrl,
    this.comments,
    this.likes,
    this.followings,
    this.followers,
    this.searchArray,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) => ReelModel(
    caption: json["caption"],
    createdAt: json["created_at"],
    id: json["id"],
    postBy: json["postBy"],
    reelUrl: json["reelUrl"],
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    likes: json["likes"] == null ? [] : List<String>.from(json["likes"]!.map((x) => x)),
    followings: json["followings"] == null ? [] : List<String>.from(json["followings"]!.map((x) => x)),
    followers: json["followers"] == null ? [] : List<String>.from(json["followers"]!.map((x) => x)),
    searchArray: json["searchArray"] == null ? [] : List<String>.from(json["searchArray"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "caption": caption,
    "created_at": createdAt,
    "id": id,
    "postBy": postBy,
    "reelUrl": reelUrl,
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
    "followings": followings == null ? [] : List<dynamic>.from(followings!.map((x) => x)),
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
    "searchArray": searchArray == null ? [] : List<dynamic>.from(searchArray!.map((x) => x)),
  };
}

class Comment {
  String? comment;
  String? date;
  String? id;
  String? time;
  String? userId;

  Comment({
    this.comment,
    this.date,
    this.id,
    this.time,
    this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    comment: json["comment"],
    date: json["date"],
    id: json["id"],
    time: json["time"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "date": date,
    "id": id,
    "time": time,
    "userId": userId,
  };
}
