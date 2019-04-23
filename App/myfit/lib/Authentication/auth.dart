import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twenty_four_hours/Authentication/UI/LRPage.dart';
import 'package:twenty_four_hours/NavigationControl.dart';



GoogleSignIn _googleSignIn = GoogleSignIn(

  scopes: <String>[

    'email',

    'https://www.googleapis.com/auth/contacts.readonly',

  ],

);
abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignInAccount _currentUser;
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    user.email;
    return user?.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user?.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser u = await _firebaseAuth.currentUser();
    print(u);

    return u?.uid;
  }

  Future<void> signOut([BuildContext c]) async {
    NavigationControl(nextPage: LRPage()).navTo(c);
    _googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }
}
