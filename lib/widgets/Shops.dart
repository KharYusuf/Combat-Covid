import 'package:Combat_Covid/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Combat_Covid/widgets/shopCard.dart';

import '../providers/shops.dart';

class Shops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shopsStream = Provider.of<ShopsPro>(context).getShops;
    User user = Provider.of<Auth>(context).user;

    return StreamBuilder<QuerySnapshot>(
        stream: shopsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<QueryDocumentSnapshot> shops = snapshot.data.docs
              .where((e) => e.data()['addedBy'] == user.uid)
              .toList();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: shops.length,
            itemBuilder: (context, i) {
              return ShopCard(shops[i]);
            },
          );
        });
  }
}
