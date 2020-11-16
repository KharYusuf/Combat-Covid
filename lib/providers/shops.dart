import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopsPro with ChangeNotifier {
  Stream<QuerySnapshot> get getShops {
    return FirebaseFirestore.instance.collection('shops').snapshots();
  }

  Future<DocumentSnapshot> getItemById(String id) async {
    return await FirebaseFirestore.instance.collection('shops').doc(id).get();
  }
}
