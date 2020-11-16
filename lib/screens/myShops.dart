import 'package:Combat_Covid/widgets/Shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class MyShops extends StatelessWidget {
  MyShops({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Theme.of(context).primaryColor);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shops"),
      ),
      body: Shops(),
    );
  }
}
