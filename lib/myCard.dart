import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String img;
  final String text;
  MyCard(this.img, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: RaisedButton(
        onPressed: () {
          print(text);
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              alignment: Alignment.center,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
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
