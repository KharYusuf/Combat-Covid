import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Products with ChangeNotifier {
  User _user;

  set setUser(User user) {
    _user = user;
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

  Future<QuerySnapshot> getShopsByProductId(final id) async {
    return await FirebaseFirestore.instance
        .collection('shops')
        .where('products', arrayContains: id)
        .get();
  }

  Future<DocumentSnapshot> getItemById(String id) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(id)
        .get();
  }

  Stream<QuerySnapshot> get getItems {
    return FirebaseFirestore.instance.collection('products').snapshots();
  }
}
