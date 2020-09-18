import 'package:Combat_Covid/screens/myCardDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class MyCard extends StatefulWidget {
  final QueryDocumentSnapshot item;

  MyCard(this.item);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  Color color = Colors.white;
  Future<bool> isFav(String id, String email) async {
    bool fav = false;
    var value = await FirebaseFirestore.instance
        .collection('userFavourites')
        .doc(email)
        .get();
    if (value.exists) {
      var val = await FirebaseFirestore.instance
          .collection('userFavourites')
          .doc(email)
          .get();
      fav = val.data()[id];
      if (fav) {
        color = Colors.pink;
      } else {
        color = Colors.white;
      }
    } else
      color = Colors.white;
    return Future.value(fav);
  }

  Future<Padding> _getPadding() async {
    var auth = Provider.of<Auth>(context).user;
    bool fav = await isFav(widget.item.id, auth.email);
    Padding pad = Padding(
      padding: EdgeInsets.all(15.0),
      child: RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(0.0),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MyCardDetails(widget.item)));
        },
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => GridTile(
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
                color: fav ? Colors.pink : Colors.white,
                onPressed: () {
                  setState(
                    () {
                      if (color == Colors.white) {
                        color = Colors.pink;
                        FirebaseFirestore.instance
                            .collection('userFavourites')
                            .doc(auth.user.email)
                            .get()
                            .then((value) {
                          if (value.exists) {
                            FirebaseFirestore.instance
                                .collection('userFavourites')
                                .doc(auth.user.email)
                                .update({widget.item.id.toString(): true});
                          } else {
                            FirebaseFirestore.instance
                                .collection('userFavourites')
                                .doc(auth.user.email)
                                .set({widget.item.id.toString(): true});
                          }
                        });
                      } else {
                        color = Colors.white;
                        FirebaseFirestore.instance
                            .collection('userFavourites')
                            .doc(auth.user.email)
                            .get()
                            .then((value) {
                          if (value.exists) {
                            FirebaseFirestore.instance
                                .collection('userFavourites')
                                .doc(auth.user.email)
                                .update({widget.item.id.toString(): false});
                          } else {
                            FirebaseFirestore.instance
                                .collection('userFavourites')
                                .doc(auth.user.email)
                                .set({widget.item.id.toString(): false});
                          }
                        });
                      }
                    },
                  );
                },
              ),
              title: Text(
                widget.item.data()['text'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
    return pad;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Padding>(
      future: _getPadding(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator();
        else {
          return snapshot.data;
        }
      },
    );
  }
}
