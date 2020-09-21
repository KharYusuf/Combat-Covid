import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCardDetails extends StatelessWidget {
  final DocumentSnapshot item;
  MyCardDetails(
    this.item,
  );
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.data()["text"]),
      ),
    );
  }
}
