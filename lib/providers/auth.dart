import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/widgets.dart';

class Auth with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  bool _signingInFirstTime = false;

  bool get signingInFirstTime {
    return _signingInFirstTime;
  }

  User get user {
    return _user;
  }

  bool get isSignIn {
    return _user != null;
  }

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    _signingInFirstTime = true;
    notifyListeners();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    UserCredential result = await _auth.signInWithCredential(credential);

    _user = result.user;
    _signingInFirstTime = false;

    if (result.additionalUserInfo.isNewUser) {
      await FirebaseFirestore.instance
          .collection('userFavourites')
          .doc(_user.uid)
          .set({'created': 'true'});
    }

    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      _user = result.user;

      if (result.additionalUserInfo.isNewUser) {
        await FirebaseFirestore.instance
            .collection('userFavourites')
            .doc(_user.uid)
            .set({'created': 'true'});
      }
    } catch (Exception) {
      return false;
    }

    if (_user == null) return false;

    notifyListeners();

    return true;
  }

  Future<void> googleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
    _user = null;

    notifyListeners();
  }
}
