import 'dart:io';
import 'dart:ui';
import 'package:college_helper/home/widgets/collegeCard.dart';
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
  bool selected = false;

  _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        controller.setMapStyle(""" [
    {
      "featureType": "poi",
      "stylers": [
        { "visibility": "off" }
      ]
    }
  ]""");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    Map<String, Map<String, String>> colleges = (args! as Map)['colleges'];
    double lat = double.parse((args as Map)['lat']);

    double lng = double.parse((args as Map)['lng']);
    List<Marker> marklist = [];
    colleges.forEach((k, v) {
      marklist.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(200),
        flat: true,
        markerId: MarkerId(k),
        position: LatLng(
            double.parse(v['lat'] ?? "0.0"), double.parse(v['lng'] ?? "0.0")),
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: CollegeCard(
                    i: 0,
                    width: width,
                    title: "Ramaiah Institute Of Technology",
                    address: "MSR Nagar, Bangalore",
                    imgUrl:
                        'https://www.iesonline.co.in/colleges-image/ramaiah-institute-of-technology.jpg',
                  ),
                );
              });
        },
      ));
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff0f0f0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const FittedBox(
          child: Text(
            "Colleges Near you",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition:
              CameraPosition(zoom: 15, target: LatLng(lat, lng)),
          markers: {...marklist}),
    );
  }
}
