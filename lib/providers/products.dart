import 'package:flutter/widgets.dart';

class Products with ChangeNotifier {
  String _userId, _token;
  Products();

  set setUserId(String userId) {
    _userId = userId;
  }

  set setToken(String token) {
    _token = token;
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
