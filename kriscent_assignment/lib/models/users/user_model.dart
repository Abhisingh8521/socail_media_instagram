
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? bio;
  List<String>? followers;
  List<String>? posts;
  List<String>? followings;
  String? gender;
  String? imageUrl;

  UserModel({
    this.id,
    this.name,
    this.bio,
    this.email,
    this.followers,
    this.posts,
    this.followings,
    this.gender,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    bio: json["bio"],
    email: json["email"],
    followers: json["followers"] == null ? [] : List<String>.from(json["followers"]!.map((x) => x)),
    posts: json["posts"] == null ? [] : List<String>.from(json["posts"]!.map((x) => x)),
    followings: json["followings"] == null ? [] : List<String>.from(json["followings"]!.map((x) => x)),
    gender: json["gender"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bio": bio,
    "email": email,
    "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x)),
    "followings": followings == null ? [] : List<dynamic>.from(followings!.map((x) => x)),
    "gender": gender,
    "image_url": imageUrl,
  };
}
