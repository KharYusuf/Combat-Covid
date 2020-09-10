import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'myCard.dart';

class Masks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardsStream = Provider.of<Products>(context).getItems;

    return StreamBuilder<QuerySnapshot>(
        stream: cardsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final cards = snapshot.data.docs;
          return GridView.builder(
            itemCount: cards.length,
            itemBuilder: (context, i) {
              return MyCard(cards[i]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
            ),
          );
        });
  }
}
