import 'package:flutter/material.dart';

class ViewShops extends StatelessWidget {
  final String id;
  final String name;
  ViewShops(this.id, this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy ' + name,
        ),
      ),
    );
  }
}
