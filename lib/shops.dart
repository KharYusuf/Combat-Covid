import 'dart:ui';

class Location {
  double latitude;
  double longitude;
  String address;
  Location({
    this.latitude,
    this.longitude,
    this.address,
  });
}

class Shops {
  String id;
  String shopName;
  Location location;
  Image img;
  Shops({
    this.id,
    this.shopName,
    this.location,
  });
}
