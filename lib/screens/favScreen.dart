import 'package:Combat_Covid/providers/products.dart';
import 'package:Combat_Covid/widgets/favItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    Provider.of<Products>(context, listen: false).setItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Favourites',
        ),
      ),
      body: FavItems(),
    );
  }
}
