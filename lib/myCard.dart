import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final String img;
  final String text;

  MyCard(this.img, this.text);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          print(widget.text);
        },
        child: GridTile(
          child: Image(
            image: NetworkImage(widget.img),
            fit: BoxFit.fitWidth,
          ),
          footer: GridTileBar(
            leading: IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {},
            ),
            backgroundColor: Colors.black54,
            trailing: IconButton(
              icon: Icon(Icons.favorite),
              color: color,
              onPressed: () {
                setState(
                  () {
                    if (color == Colors.white)
                      color = Colors.pink;
                    else
                      color = Colors.white;
                  },
                );
              },
            ),
            title: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
