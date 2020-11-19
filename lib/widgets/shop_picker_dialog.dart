import 'dart:io';

import 'package:Combat_Covid/providers/auth.dart';
import 'package:Combat_Covid/screens/map_screen.dart';
import 'package:Combat_Covid/widgets/shop_item_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

import '../secrets.dart';
import 'image_input.dart';

class ShopPickerDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const API_KEY = MAPS_API_KEY;

  String genStaticImageURL(String latitude, String longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?markers=$latitude,$longitude&zoom=17&size=400x250&key=$API_KEY";
  }

  @override
  Widget build(BuildContext context) {
    Set<String> selectedItems = Set();
    File _image;

    void _selectImage(File pickedImage) {
      _image = pickedImage;
    }

    User user = Provider.of<Auth>(context).user;
    final _shopController = TextEditingController();
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            bool shopPicked = false;
            String latitude, longitude, address;
            String display = "Select your Shop's Location";
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
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
                                child: const Text('Select your products'),
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
                                            shopPicked = true;
                                            latitude = lat;
                                            longitude = lng;
                                            display =
                                                "Change your Shop's Location";
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
                              shopPicked
                                  ? Column(
                                      children: <Widget>[
                                        Container(
                                          child: Image.network(
                                            genStaticImageURL(
                                                latitude, longitude),
                                          ),
                                        ),
                                        Text(address),
                                      ],
                                    )
                                  : Text('No preview available'),
                              SizedBox(
                                height: 20,
                              ),
                              ImageInput(_selectImage),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submit"),
                                  onPressed: () async {
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
                                    } else if (!shopPicked) {
                                      Flushbar(
                                        message: "Select Shop Location",
                                        icon: Icon(
                                          Icons.error,
                                          size: 28.0,
                                          color: Colors.blue[300],
                                        ),
                                        duration: Duration(seconds: 5),
                                        leftBarIndicatorColor: Colors.blue[300],
                                      )..show(context);
                                    } else if (_image == null) {
                                      Flushbar(
                                        message: "Capture Shop's Image",
                                        icon: Icon(
                                          Icons.error,
                                          size: 28.0,
                                          color: Colors.blue[300],
                                        ),
                                        duration: Duration(seconds: 5),
                                        leftBarIndicatorColor: Colors.blue[300],
                                      )..show(context);
                                    } else {
                                      final String fileName =
                                          basename(_image.path);
                                      final StorageReference
                                          firebaseStorageRef = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child('shops/$fileName');
                                      final StorageUploadTask uploadTask =
                                          firebaseStorageRef.putFile(_image);
                                      final StorageTaskSnapshot taskSnapshot =
                                          await uploadTask.onComplete;
                                      final String downloadURL =
                                          await taskSnapshot.ref
                                              .getDownloadURL();
                                      FirebaseFirestore.instance
                                          .collection('shops')
                                          .add({
                                        'name': _shopController.text,
                                        'image': downloadURL,
                                        'latitude': latitude,
                                        'longitude': longitude,
                                        'products': selectedItems.toList(),
                                        'address': address,
                                        'addedBy': user.uid,
                                      });
                                      _shopController.text = '';
                                      selectedItems.clear();
                                      _image = null;
                                      shopPicked = false;
                                      _formKey.currentState.save();
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
