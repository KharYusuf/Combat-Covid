import 'package:flutter/material.dart';

class MyCardDetails extends StatelessWidget {
  final String productId;
  MyCardDetails(
    this.productId,
  );
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
