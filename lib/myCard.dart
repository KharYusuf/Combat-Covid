import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String img;
  final String text;
  MyCard(this.img, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {
          print(text);
        },
        child: Stack( 
          children: <Widget>[
            Container(
              height: 200,
              alignment: Alignment.topCenter,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 200,
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                child: Text(
                  text,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
