import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rat_order/constant.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:rat_order/helper/myLocationClass.dart';
import 'package:rat_order/helper/providerHelper.dart';

class AddLocationMap extends StatefulWidget {
  static final String id = 'AddLocationMap';
  @override
  State<AddLocationMap> createState() => AddLocationMapState();
}

class AddLocationMapState extends State<AddLocationMap> {
  bool test = false;
  int idx = -1;
  LatLng currentLatLng;
  final _formKey = GlobalKey<FormState>();
  GoogleMapController _controller;
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _nextToController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  static CameraPosition _kGooglePlex;
  @override
  void initState() {
    super.initState();

    currentLatLng = LatLng(33.51003216690846, 36.2760264895256);

    if (context.read<ProviderHelper>().theEditedLocationIdx != -1) {
      idx = context.read<ProviderHelper>().theEditedLocationIdx;
      Locations location = context.read<ProviderHelper>().locationList[idx];
      _placeController.text = location.placeName;
      _streetController.text = location.street;
      _nextToController.text = location.nextTo;
      _floorController.text = location.floor;
      _detailsController.text = location.details;

      currentLatLng = location.lngLat;
      _kGooglePlex = CameraPosition(
        target: location.lngLat,
        zoom: 17,
      );
    } else {
      _kGooglePlex = CameraPosition(
        target: LatLng(33.51003216690846, 36.2760264895256),
        zoom: 10,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
              onCameraMove: (latLan) {
                currentLatLng = latLan.target;
              },
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) => _controller = controller,
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 2 - 20,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: firstColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Ionicons.location_outline,
                  size: 40,
                  color: firstColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: gotoCurrentLocation,
                    child: Icon(Ionicons.locate),
                    backgroundColor: firstColor,
                  ),
                  MyButton(
                    buttonColor: firstColor,
                    buttonText: idx == -1 ? 'التالي' : 'تعديل',
                    width: MediaQuery.of(context).size.width,
                    buttonFunction: () {
                      if (idx == -1) {
                        _placeController.clear();
                        _streetController.clear();
                        _nextToController.clear();
                        _floorController.clear();
                        _detailsController.clear();
                      }
                      _showBottomSheet();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.7,
      maxHeight: 0.9,
      context: context,
      builder: (BuildContext context, ScrollController scrollController,
          double offset) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ListView(
                controller: scrollController,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            text: 'المنطقة',
                            textEditingController: _placeController,
                          ),
                          TextFieldWidget(
                              text: 'الشارع',
                              textEditingController: _streetController),
                          TextFieldWidget(
                              text: 'قريب من',
                              textEditingController: _nextToController),
                          TextFieldWidget(
                              text: 'الطابق',
                              textEditingController: _floorController),
                          TextFormField(
                            controller: _detailsController,
                            cursorColor: firstColor,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'التفاصيل',
                            ),
                            onFieldSubmitted: (String text) {},
                            validator: TextFieldWidget._validateInput,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    buttonColor: firstColor,
                    buttonText: idx == -1 ? 'التالي' : 'تعديل',
                    width: double.infinity,
                    buttonFunction: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          Locations location = new Locations(
                              placeName: _placeController.text,
                              street: _streetController.text,
                              nextTo: _nextToController.text,
                              floor: _floorController.text,
                              details: _detailsController.text,
                              lngLat: currentLatLng);
                          idx == -1
                              ? context
                                  .read<ProviderHelper>()
                                  .addToLocationsList(location)
                              : context
                                  .read<ProviderHelper>()
                                  .updateLocationsList(location, idx);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Unexpected error"),
                            ),
                          );
                        }
                        test = true;
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
      anchors: [0, 0.5, 1],
    ).whenComplete(() {
      if (test) Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void gotoCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 15),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unexpected error"),
      ));
    }
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    @required this.textEditingController,
    @required this.text,
  });

  final TextEditingController textEditingController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validateInput,
      controller: textEditingController,
      cursorColor: firstColor,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: text,
      ),
    );
  }

  static String _validateInput(String value) {
    return value == null || value.length == 0 ? 'مطلوب' : null;
  }
}
