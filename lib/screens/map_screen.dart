import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function setCoords;

  MapScreen(this.setCoords);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String latitude, longitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: latitude == null
                ? null
                : () {
                    widget.setCoords(latitude, longitude);
                    Navigator.of(context).pop();
                  },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(28.7041, 77.1025),
          zoom: 16,
        ),
        onTap: (LatLng loc) {
          setState(() {
            latitude = loc.latitude.toString();
            longitude = loc.longitude.toString();
            print(latitude);
          });
        },
        markers: latitude == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: LatLng(
                    double.parse(latitude),
                    double.parse(longitude),
                  ),
                ),
              },
      ),
    );
  }
}
