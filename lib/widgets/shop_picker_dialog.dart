import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class ShopPickerDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  static const API_KEY = 'AIzaSyC39Xs7KWEucJ3I8VElpG6LkGAzALD12ME';

  String genStaticImageURL(String latitude, String longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?markers=$latitude,$longitude&zoom=17&size=400x250&key=$API_KEY";
  }

  @override
  Widget build(BuildContext context) {
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Name of Shop",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text(display),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                        apiKey: API_KEY,
                                        onPlacePicked: (result) {
                                          setState(() {
                                            address = result.formattedAddress;
                                            shopPicked = true;
                                            latitude = result
                                                .geometry.location.lat
                                                .toString();
                                            longitude = result
                                                .geometry.location.lng
                                                .toString();
                                            display =
                                                "Change your Shop's Location";
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        initialPosition:
                                            LatLng(28.7041, 77.1025),
                                        useCurrentLocation: true,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            shopPicked
                                ? Column(
                                    children: <Widget>[
                                      Container(
                                        height: 180,
                                        width: 250,
                                        child: Image.network(
                                          genStaticImageURL(
                                              latitude, longitude),
                                          fit: BoxFit.cover,
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
