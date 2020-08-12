import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String img;
  final String text;
  MyCard(this.img, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(text);
        },
        child: GridTile(
          child: Image.asset(
            img,
            fit: BoxFit.fitWidth,
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {},
            ),
            backgroundColor: Colors.black54,
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
