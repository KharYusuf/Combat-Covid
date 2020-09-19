import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Products with ChangeNotifier {
  User _user;
  Stream<DocumentSnapshot> favStream;

  set setUser(User user) {
    _user = user;
    if (user != null) {
      favStream = FirebaseFirestore.instance
          .collection('userFavourites')
          .doc(_user.uid)
          .snapshots();
    }
  }

  void setItems() {
    _cards = FirebaseFirestore.instance.collection('products').snapshots();
  }

  Stream<DocumentSnapshot> get getFav {
    return favStream;
  }

  Future<void> toggleFav(final id) async {
    final doc =
        FirebaseFirestore.instance.collection('userFavourites').doc(_user.uid);
    bool setTo = !await doc.get().then((value) => value.data()[id] ?? false);
    doc.update({id: setTo});
  }

  Stream<QuerySnapshot> _cards;

  Stream<QuerySnapshot> get getItems {
    return _cards;
  }
}
