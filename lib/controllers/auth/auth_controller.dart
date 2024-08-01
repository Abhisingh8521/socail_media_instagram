import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController {
  var auth = FirebaseAuth.instance;

  Future<User?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final authUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (authUser.user != null) {
        return authUser.user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: e.message ?? "Something went wrong");
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: e.message ?? "Something went wrong");
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<User?> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final authUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (authUser.user != null) {
        return authUser.user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: e.message ?? "Something went wrong");

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: e.message ?? "Something went wrong");

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

 bool isLogin(){
    return auth.currentUser != null?true:false;
  }

  Future<bool> logoutUser()async{
    var value = false;
    if(auth.currentUser != null){
      await auth.signOut();
      if(auth.currentUser != null){
        value = false;
      }else{
        value = true;
      }
    }else{
      value = true;
      Fluttertoast.showToast(msg: "Logout failed");
    }
    return value;
  }

  Future<bool> addNewUser(String name, String email)async {
    var isAdded = false;
    var store = FirebaseFirestore.instance.collection("users");
    var id = FirebaseAuth.instance.currentUser?.uid;
    var date = DateTime.now().toString();
   try{
     await store.doc(id.toString()).set({
       "name":name,
       "email":email,
       "id":id,
       "created_at":date
     }).then((_){
       isAdded = true;
     });
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       Fluttertoast.showToast(msg: e.message ?? "Something went wrong");

       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       Fluttertoast.showToast(msg: e.message ?? "Something went wrong");

       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }

   return isAdded;
  }
}
