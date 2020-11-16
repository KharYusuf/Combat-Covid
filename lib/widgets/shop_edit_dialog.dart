import 'package:Combat_Covid/providers/auth.dart';
import 'package:Combat_Covid/providers/shops.dart';
import 'package:Combat_Covid/screens/map_screen.dart';
import 'package:Combat_Covid/widgets/shop_item_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../secrets.dart';

class ShopEditDialog extends StatefulWidget {
  static const API_KEY = MAPS_API_KEY;

  final String id;
  ShopEditDialog(this.id);

  @override
  _ShopEditDialogState createState() => _ShopEditDialogState();
}

class _ShopEditDialogState extends State<ShopEditDialog> {
  final _formKey = GlobalKey<FormState>();

  String genStaticImageURL(String latitude, String longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?markers=$latitude,$longitude&zoom=17&size=400x250&key=${ShopEditDialog.API_KEY}";
  }

  @override
  Widget build(BuildContext context) {
    Set<String> selectedItems = Set();
    DocumentSnapshot shop;
    User user = Provider.of<Auth>(context).user;
    var _shopController = TextEditingController();

    String latitude, longitude, address;
    String display = "Change your Shop's Location";
    var products;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Shop"),
      ),
      body: FutureBuilder(
          future: Provider.of<ShopsPro>(context).getItemById(widget.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              shop = snapshot.data;
              latitude = shop.data()['latitude'];
              longitude = shop.data()['longitude'];
              address = shop.data()['address'];
              products = shop.data()['products'];
              for (var i = 0; i < products.length; ++i) {
                selectedItems.add(products[i]);
              }
              _shopController = TextEditingController(
                text: shop.data()['name'],
              );
              return StatefulBuilder(builder: (context, setState) {
                return Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _shopController,
                                decoration: InputDecoration(
                                  hintText: "Name of Shop",
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8.0),
                              child: const Text('Update your products'),
                            ),
                            ShopItemSelector(selectedItems),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text(display),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                      (final addr, final lat, final lng) {
                                        setState(() {
                                          address = addr;
                                          latitude = lat;
                                          longitude = lng;
                                        });
                                      },
                                      latitude == null
                                          ? 28.7041
                                          : double.parse(latitude),
                                      longitude == null
                                          ? 77.1025
                                          : double.parse(longitude),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: Image.network(
                                    genStaticImageURL(latitude, longitude),
                                  ),
                                ),
                                Text(address),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                  if (selectedItems.isEmpty) {
                                    Flushbar(
                                      message: "Select atleast 1 product",
                                      icon: Icon(
                                        Icons.error,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: Duration(seconds: 5),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    )..show(context);
                                  } else if (_shopController.text.isEmpty) {
                                    Flushbar(
                                      message: "Enter non empty shop name",
                                      icon: Icon(
                                        Icons.error,
                                        size: 28.0,
                                        color: Colors.blue[300],
                                      ),
                                      duration: Duration(seconds: 5),
                                      leftBarIndicatorColor: Colors.blue[300],
                                    )..show(context);
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection('shops')
                                        .doc(shop.id)
                                        .update({
                                      'name': _shopController.text,
                                      'latitude': latitude,
                                      'longitude': longitude,
                                      'products': selectedItems.toList(),
                                      'addedBy': user.uid,
                                      'address': address,
                                    });
                                    _formKey.currentState.save();
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
            }
          }),
    );
  }
}
