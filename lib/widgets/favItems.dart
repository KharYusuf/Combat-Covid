import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'myCard.dart';

class FavItems extends StatelessWidget {
  getFavCards(var snapshot, BuildContext context) async {
    final cards = snapshot.data.data();

    var favCards = [];
    for (var e in cards.entries) {
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
          return FutureBuilder(
            future: getFavCards(snapshot, context),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, i) {
                  return FutureBuilder(
                    future: Provider.of<Products>(context)
                        .getItemById(snap.data[i]),
                    builder: (context, sna) {
                      if (sna.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return MyCard(sna.data);
                      }
                    },
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                ),
              );
            },
          );
        });
  }
}
