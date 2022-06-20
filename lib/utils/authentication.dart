import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? getEmail() {
    return _auth.currentUser!.email;
  }

  Future<String?> signInwithGoogle(var context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print("Done signing to google ");
      await _auth.signInWithCredential(credential);
      print("Done signing to firebase ");
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<bool> isUserLoggedin() async {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return false;
    } else {
      return true;
    }
  }

  Widget getProfileImg() {
    if (_auth.currentUser?.photoURL != null) {
      print(_auth.currentUser!.photoURL);
      return CircleAvatar(
          radius: 50,
          backgroundImage: Image.network(_auth.currentUser!.photoURL!).image);
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundImage: Image.asset(
          'assets/images/profile_image.jpg',
        ).image,
      );
    }
  }

  String getUserName() {
    if (_auth.currentUser?.displayName != null)
      return _auth.currentUser!.displayName!;
    else
      return "User 1234";
  }

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;
    return user;
  }

  Future<User> getCurrentUser() {
    return handleSignInEmail(_auth.currentUser!.email!, "1234567890");
  }

  Future<void> UpdateUsername(String username) async {
    await _auth.currentUser!.updateDisplayName(username);
  }

  Future<void> UpdateProfilePic(String photoURL) async {
    await _auth.currentUser!.updatePhotoURL(photoURL);
  }
}
