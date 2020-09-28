import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../secrets.dart';

class MapScreen extends StatelessWidget {
  final Function setShop;
  final double lat, lng;
  MapScreen(this.setShop, this.lat, this.lng);

  static const API_KEY = MAPS_API_KEY;
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: API_KEY,
      onPlacePicked: (result) {
        setShop(
          result.formattedAddress,
          result.geometry.location.lat.toString(),
          result.geometry.location.lng.toString(),
        );
        Navigator.of(context).pop();
      },
      initialPosition: LatLng(lat, lng),
      useCurrentLocation: true,
    );
  }
}
