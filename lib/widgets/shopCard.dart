import 'package:Combat_Covid/widgets/shop_edit_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatefulWidget {
  final DocumentSnapshot item;

  ShopCard(this.item);

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
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
                  widget.item.data()['image'],
                ),
              ),
              footer: GridTileBar(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShopEditDialog(widget.item.id),
                      ),
                    );
                  },
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
