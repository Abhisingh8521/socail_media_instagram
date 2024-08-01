import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kriscent_assignment/models/reels/reel_model.dart';

class ReelController {
  final _firebaseStore = FirebaseFirestore.instance.collection("posts");
  final _storage = FirebaseStorage.instance.ref("posts");

  Future<void> postMedia(File file, Function(TaskSnapshot) onLoaded) async {
    var fileName = file.path.split("/").last;
    try {
      final ref = _storage.child('$fileName.mp4');
      ref.putFile(file).then(onLoaded);
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<void> addPost(ReelModel reel) async {
    try {
      await _firebaseStore.doc(reel.id).set(reel.toJson()).then((_) {
        Fluttertoast.showToast(msg: "Post Added");
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: "${e.message}");
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllReels() async {
    return await _firebaseStore.get();
  }
  Future<QuerySnapshot<Map<String, dynamic>>> getMyReels() async {
    var id = FirebaseAuth.instance.currentUser?.uid;
    return await _firebaseStore.where("postBy",isEqualTo: id).get();
  }


 Future<QuerySnapshot<Map<String, dynamic>>> searchReels(String text) async{
    if(text.isEmpty || text == ""){
      return await _firebaseStore.get();
    }else{
      return await _firebaseStore.where("searchArray",arrayContains: text).get();
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getReel(String reelId){
    return _firebaseStore.doc(reelId).snapshots();
  }

  makeReelLiked(String reelId,String id)async{
    await _firebaseStore.doc(reelId).update({"likes":[id]});
  }
  removeReelLiked(String reelId,String id)async{
    await _firebaseStore.doc(reelId).update({"likes":FieldValue.arrayRemove([id])});
  }

  followUser(String reelId,String id,bool isFollowing)async{
    if(isFollowing == false){
      await _firebaseStore.doc(reelId).update({"followings":[id]});
    }else{
      await _firebaseStore.doc(reelId).update({"followings":FieldValue.arrayRemove([id])});
    }
  }

  addNewPost(String id,String userId)async{
    await FirebaseFirestore.instance.collection("users").doc(userId).update({"posts":FieldValue.arrayUnion([id])});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAllComments(String reelId) {
    return _firebaseStore.doc(reelId).snapshots();
  }

  Future<void> addNewComment(String reelId, Comment data) async {
    await _firebaseStore.doc(reelId).update({
      "comments":FieldValue.arrayUnion([data.toJson()])
    });
  }
}
