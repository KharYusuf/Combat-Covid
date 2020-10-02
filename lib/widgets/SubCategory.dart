import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'myCard.dart';

class SubCategory extends StatelessWidget {
  final String title;
  SubCategory(this.title);

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
          final List visibleCards = snapshot.data.docs
              .where((e) => e.data()['Type'] == title)
              .toList();
          return GridView.builder(
            itemCount: visibleCards.length,
            itemBuilder: (context, i) {
              return MyCard(visibleCards[i]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
            ),
          );
        });
  }
}
