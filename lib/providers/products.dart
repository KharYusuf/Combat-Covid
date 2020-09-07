import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  User _user;

  set setUser(User user) {
    _user = user;
  }

  static const cards = const [
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My first Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/assets%2Fhomemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
  ];

  List<Map<String, String>> get getItems {
    return cards;
  }
}
