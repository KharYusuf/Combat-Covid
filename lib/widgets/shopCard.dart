import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Combat_Covid/secrets.dart';

class ShopCard extends StatefulWidget {
  final DocumentSnapshot item;

  ShopCard(this.item);

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  static const API_KEY = MAPS_API_KEY;

  String genStaticImageURL(String latitude, String longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?markers=$latitude,$longitude&zoom=17&size=400x250&key=$API_KEY";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: GridTile(
              child: Image(
                image: NetworkImage(
                  genStaticImageURL(
                    widget.item.data()['latitude'],
                    widget.item.data()['longitude'],
                  ),
                ),
              ),
              footer: GridTileBar(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
                backgroundColor: Colors.black54,
                title: Text(
                  widget.item.data()['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
