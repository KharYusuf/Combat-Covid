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
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              if (snapshot.hasData) {
                if (snapshot.data == null)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                final cards = snapshot.data.docs;
                return GridView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, i) {
                    return MyCard(
                      cards[i].data()['img'],
                      cards[i].data()['text'],
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                  ),
                );
              }
              return Text('');
            case ConnectionState.none:
              return new Text('Not connected to the Stream or null');
            case ConnectionState.done:
              return new Text('Streaming is done');
            default:
              return Text('Some error occured');
          }
        });
  }
}
