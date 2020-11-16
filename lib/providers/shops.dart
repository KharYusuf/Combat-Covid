import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopsPro with ChangeNotifier {
  Stream<QuerySnapshot> get getShops {
    return FirebaseFirestore.instance.collection('shops').snapshots();
  }
}
