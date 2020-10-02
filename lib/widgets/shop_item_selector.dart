import 'package:Combat_Covid/providers/products.dart';
import 'package:Combat_Covid/widgets/shop_subcategory_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopItemSelector extends StatelessWidget {
  Set<String> selectedItems;

  ShopItemSelector(this.selectedItems);

  @override
  Widget build(BuildContext context) {
    final cards = {
      'Mask': Provider.of<Products>(context).getItems,
      'Sanitizer': Provider.of<Products>(context).getItems,
      'Soap': Provider.of<Products>(context).getItems,
    };
    return Container(
        height: 170,
        width: 200,
        child: ListView(
          children: cards.entries
              .map(
                  (e) => ShopSubcategorySelector(e.value, e.key, selectedItems))
              .toList(),
        ));
  }
}
