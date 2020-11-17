import 'package:Combat_Covid/screens/shop_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ViewShops extends StatelessWidget {
  final String id;
  final String name;
  ViewShops(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    Future<QuerySnapshot> _getShops() async =>
        await Provider.of<Products>(context).getShopsByProductId(id);

    Set<Marker> _getMarkers(List<QueryDocumentSnapshot> shops) {
      Set<Marker> markers = Set();

      print(markers.length);

      int markerId = 1;

      shops.forEach((element) {
        markers.add(Marker(
          markerId: MarkerId('m$markerId'),
          infoWindow: InfoWindow(
            title: element.data()['name'],
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShopDetailScreen(
                      element.data()['name'], element.data()['products'])));
            },
          ),
          position: LatLng(
            double.parse(element.data()['latitude']),
            double.parse(element.data()['longitude']),
          ),
        ));
        markerId++;
      });

      print(shops.length);

      print('Length of returned set: ' + markers.length.toString());

      return markers;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy ' + name,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _getShops(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              print(snapshot.data.docs.length);
            }
            return GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(28.7041, 77.1025), zoom: 16),
              markers: snapshot.connectionState == ConnectionState.waiting
                  ? {}
                  : _getMarkers(snapshot.data.docs),
            );
          }),
    );
  }
}
