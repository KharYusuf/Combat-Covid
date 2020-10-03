import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'myCard.dart';

class FavItems extends StatelessWidget {
  getFavCards(var snapshot) {
    final cards = snapshot.data.data();
    var favCards = [];
    for (final e in cards.entries) {
      if (e.value) {
        favCards.add(e.key);
      }
    }
    return favCards;
  }

  @override
  Widget build(BuildContext context) {
    final favStream = Provider.of<Products>(context).getFav;

    return StreamBuilder<DocumentSnapshot>(
        stream: favStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final favCards = getFavCards(snapshot);
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favCards.length,
            itemBuilder: (context, i) => FutureBuilder(
              future: Provider.of<Products>(context).getItemById(favCards[i]),
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return MyCard(snapshot1.data);
                }
              },
            ),
          );
        });
  }
}
