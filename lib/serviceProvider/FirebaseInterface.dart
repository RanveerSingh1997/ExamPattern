import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_21/serviceProvider/firebaseMethods.dart';

class FirebaseInterface extends ChangeNotifier {
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  User _user;
  bool _loading = false;

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  FirebaseMethods get firebaseMethods => _firebaseMethods;

  set firebaseMethods(FirebaseMethods value) {
    _firebaseMethods = value;
  }

  sigInWithGoogleAccount() {
    loading = true;
    _firebaseMethods.signInWithGoogle().then((value) {
      loading = false;
      if (value != null) {
        user=value;
      } else {

      }
    });
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }
}
