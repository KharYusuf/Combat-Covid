import 'package:Combat_Covid/screens/map_screen.dart';
import 'package:Combat_Covid/widgets/shop_item_selector.dart';
import 'package:flutter/material.dart';

import '../secrets.dart';

class ShopPickerDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const API_KEY = MAPS_API_KEY;

  String genStaticImageURL(String latitude, String longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?markers=$latitude,$longitude&zoom=17&size=400x250&key=$API_KEY";
  }

  @override
  Widget build(BuildContext context) {
    Set<String> selectedItems = Set();
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter a non empty name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Name of Shop",
                                  ),
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.0),
                                  child: const Text('Select your products')),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submit"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
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
