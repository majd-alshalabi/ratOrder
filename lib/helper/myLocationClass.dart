import 'package:google_maps_flutter/google_maps_flutter.dart';

class Locations {
  String placeName;
  String street;
  String nextTo;
  String floor;
  String details;
  LatLng lngLat;

  Locations(
      {this.placeName,
      this.details,
      this.floor,
      this.nextTo,
      this.street,
      this.lngLat});
}
