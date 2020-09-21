import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Products with ChangeNotifier {
  User _user;

  set setUser(User user) {
    _user = user;
  }

  void setItems() {
    _cards = FirebaseFirestore.instance.collection('products').snapshots();
  }

  Stream<DocumentSnapshot> get getFav {
    return FirebaseFirestore.instance
        .collection('userFavourites')
        .doc(_user.uid)
        .snapshots();
  }

  Future<void> toggleFav(final id) async {
    final doc =
        FirebaseFirestore.instance.collection('userFavourites').doc(_user.uid);
    bool setTo = !await doc.get().then((value) => value.data()[id] ?? false);
    doc.update({id: setTo});
  }

  Stream<QuerySnapshot> _cards;

  Future<DocumentSnapshot> getItemById(String id) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .get();
  }

  Stream<QuerySnapshot> get getItems {
    return _cards;
  }
}
