import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  String _userId;
  String _token;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  String get userId {
    return _userId;
  }

  String get token {
    return _token;
  }

  bool get isSignIn {
    return _userId != null;
  }

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    UserCredential result = await _auth.signInWithCredential(credential);

    _user = result.user;

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    final userData = json.encode(
      {
        'userId': _user.uid,
        'token': await _user.getIdToken(),
      },
    );
    prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _userId = extractedUserData['userId'];
    _token = extractedUserData['token'];
    notifyListeners();

    return true;
  }

  Future<void> googleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
    _userId = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    notifyListeners();
  }
}
