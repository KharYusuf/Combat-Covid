import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String img;
  final String text;
  MyCard(this.img, this.text);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        print(text);
      },
      child: Stack(
        children: <Widget>[
          Container(
              height: 200,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              )),
          Text(text)
        ],
      ),
    );
  }
}
