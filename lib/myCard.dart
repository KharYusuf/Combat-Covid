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
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(text);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
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
              height: 40,
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: FittedBox(
                alignment: Alignment.bottomCenter,
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
