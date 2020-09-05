import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  User _user;
  Products();

  set setUser(User user) {
    _user = user;
  }

  static const cards = const [
    {'img': 'assets/homemade_face_mask.png', 'text': 'My first Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
    {'img': 'assets/homemade_face_mask.png', 'text': 'My Second Card'},
  ];

  List<Map<String, String>> get getItems {
    return cards;
  }
}
