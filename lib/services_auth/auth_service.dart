import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //instance  of FireStore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign user in
  Future<UserCredential> signInWithEmailLangPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
          email: email,
          password: password
      );
      //add a new document for the user in users collection if it doesn't already exists
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));

      return userCredential;
    }
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //create a new user
  Future<UserCredential> signUpEmailandPassword(
      String email, password) async{
    try {
      UserCredential userCredential =
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      //after creating the user, create a new document for user in the users
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    }on FirebaseAuthException catch (e) {
      throw Exception(e.code);

    }
  }

  //sign user out
Future<void> signOut() async{
    return await FirebaseAuth.instance.signOut();
}
}
