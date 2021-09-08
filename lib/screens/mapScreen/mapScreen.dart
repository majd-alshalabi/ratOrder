import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rat_order/helper/providerHelper.dart';

class MapScreen extends StatefulWidget {
  static final String id = 'MapScreen';
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex;
  List<Marker> markerList = [];
  @override
  void initState() {
    super.initState();

    markerList.add(
      Marker(
          markerId: MarkerId('SomeId'),
          position: context.read<ProviderHelper>().langAndLat(),
          infoWindow: InfoWindow(
            title: 'The title of the marker',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
    );
    _kGooglePlex = CameraPosition(
      target: context.read<ProviderHelper>().langAndLat(),
      zoom: 17.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markerList),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

/*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/