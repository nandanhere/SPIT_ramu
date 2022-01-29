import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  static const routeName = "/mapscreen";
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation = LatLng(0.0, 0.0);
  String address = "";
  void _selectLocation(LatLng position) async {
    setState(() {
      _pickedLocation = position;
      address = "";
    });
    try {
      address = await LocationHelper.getPlaceAddress(
          position.latitude, position.longitude);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    Map<String, Map<String, String>> potholes = (args! as Map)['potholes'];
    double lat = double.parse((args as Map)['lat']);

    double lng = double.parse((args as Map)['lng']);
    List<Marker> marklist = [];
    potholes.forEach((k, v) {
      print(k);
      print(v);
      print("marklist made");
      marklist.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(200),
        flat: true,
        markerId: MarkerId(k),
        position: LatLng(
            double.parse(v['lat'] ?? "0.0"), double.parse(v['lng'] ?? "0.0")),
        onTap: () => print(v['id']),
      ));
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff0f0f0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        title: FittedBox(
          child: Text(
            "Register a complaint",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition:
                  CameraPosition(zoom: 18, target: LatLng(lat, lng)),
              markers: {...marklist}),
          Container(
            height: MediaQuery.of(context).size.height * 5 / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          )
        ],
      ),
    );
  }
}
