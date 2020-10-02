import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopSubcategorySelector extends StatefulWidget {
  final Stream<QuerySnapshot> cardsStream;
  final String title;
  Set<String> selectedItems;

  ShopSubcategorySelector(this.cardsStream, this.title, this.selectedItems);

  @override
  _ShopSubcategorySelectorState createState() =>
      _ShopSubcategorySelectorState();
}

class _ShopSubcategorySelectorState extends State<ShopSubcategorySelector> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.cardsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final cards = snapshot.data.docs
              .where((element) => element.data()['Type'] == widget.title)
              .toList();
          return ExpansionTile(
            title: Text(widget.title),
            children: [
              SingleChildScrollView(
                child: Column(
                  children: cards
                      .map((e) => CheckboxListTile(
                            title: Text(e.data()['text']),
                            value: widget.selectedItems.contains(e.id),
                            onChanged: (bool value) {
                              setState(() {
                                if (widget.selectedItems.contains(e.id)) {
                                  widget.selectedItems.remove(e.id);
                                } else {
                                  widget.selectedItems.add(e.id);
                                }
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        });
  }
}
