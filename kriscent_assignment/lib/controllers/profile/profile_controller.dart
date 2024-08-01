import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kriscent_assignment/models/users/user_model.dart';

class ProfileController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection("users");
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File image) async {
    try {
      final user = _auth.currentUser;
      final ref = _storage.ref("users").child('${user!.uid}.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addNewUser(UserModel user) async {
    await _firestore.add(user.toJson());
  }

  followUser(String id,bool isFollowing)async{
    if(isFollowing == false){
      await _firestore.doc(id).update({"followings":[id]});
    }else{
      await _firestore.doc(id).update({"followings":FieldValue.arrayRemove([id])});
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String bio,
    required String gender,
    required String imageUrl,
  }) async {
    try {
      final user = _auth.currentUser;
      await _firestore.doc(user!.uid).update({
        'name': name,
        'bio': bio,
        'gender': gender,
        'image_url': imageUrl,
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() {
    final user = _auth.currentUser;
    return _firestore.doc(user?.uid).snapshots();
  }

  Future<UserModel> getUser(String id) async {
    var data = await _firestore.doc(id).get();
    var user = UserModel.fromJson(data.data() ?? <String, dynamic>{});
    return user;
  }
}
