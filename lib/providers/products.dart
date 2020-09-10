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
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My first Card'
  // },
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My Second Card'
  // },
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My Second Card'
  // },
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My Second Card'
  // },
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My Second Card'
  // },
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My Second Card'
  // },
  // {
  //   'img':
  //       'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
  //   'text': 'My Second Card'
  // },
  // ];

  Stream<QuerySnapshot> get getItems {
    return _cards;
  }
}
