import 'dart:io';
import 'dart:ui';
import 'package:college_helper/home/widgets/collegeCard.dart';
import 'package:college_helper/models/collegeDetails.dart';
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
    double lat = double.parse((args as Map)['lat']);
    CollegeDetail deets = (args as Map)['deets'];
    print(deets.colleges.length);
    double lng = double.parse((args as Map)['lng']);
    List<Marker> marklist = [];
    for (int i = 0; i < deets.colleges.length; i++) {
      CollegeElement v = deets.colleges[i];
      marklist.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(200),
        flat: true,
        markerId: MarkerId(deets.colleges[i].id),
        position:
            LatLng(v.coordinates[0] as double, v.coordinates[1] as double),
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: CollegeCard(
                        i: i,
                        width: width,
                        title: v.college.name,
                        address: v.address,
                        imgUrl: v.imageUrls[0]));
              });
        },
      ));
    }
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
