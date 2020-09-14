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

  Stream<QuerySnapshot> _cards;

  Stream<QuerySnapshot> get getItems {
    return _cards;
  }
}
