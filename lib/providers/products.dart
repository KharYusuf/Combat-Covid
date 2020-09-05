import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  User _user;
  Products();

  set setUser(User user) {
    _user = user;
  }

  var cards = [
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My first Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
    {
      'img':
          'https://firebasestorage.googleapis.com/v0/b/combat-covid-6fe68.appspot.com/o/homemade_face_mask.png?alt=media',
      'text': 'My Second Card'
    },
  ];

  List<Map<String, String>> get getItems {
    return cards;
  }
}
