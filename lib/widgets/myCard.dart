import 'package:Combat_Covid/screens/myCardDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final QueryDocumentSnapshot item;

  MyCard(this.item);

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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyCardDetails(widget.item)));
        },
        child: GridTile(
          child: Image(
            image: NetworkImage(widget.item.data()['img']),
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
              widget.item.data()['text'],
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
