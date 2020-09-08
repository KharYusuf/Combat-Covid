import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import 'myCard.dart';

class Masks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cards = Provider.of<Products>(context).getItems;
    return GridView.builder(
      itemCount: cards.length,
      itemBuilder: (context, i) {
        return MyCard(
          cards[i]['img'],
          cards[i]['text'],
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
      ),
    );
  }
}
