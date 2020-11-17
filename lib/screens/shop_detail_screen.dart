import 'package:Combat_Covid/widgets/myCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ShopDetailScreen extends StatelessWidget {
  final String title, url;

  final List<dynamic> products;

  ShopDetailScreen(this.title, this.url, this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to our shop! ',
              style: Theme.of(context).accentTextTheme.bodyText1,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'The following items are available at our shop: ',
              style: Theme.of(context).accentTextTheme.bodyText1,
            ),
            ...products.map((e) => FutureBuilder<DocumentSnapshot>(
                  future: Provider.of<Products>(context).getItemById(e),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : MyCard(snapshot.data),
                ))
          ],
        ),
      ),
    );
  }
}
