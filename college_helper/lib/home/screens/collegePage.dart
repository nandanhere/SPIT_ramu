import 'package:college_helper/home/widgets/titleText.dart';
import 'package:college_helper/map_screen.dart';
import 'package:flutter/material.dart';

class CollegePage extends StatelessWidget {
  static const routeName = "/collegePage";

  String collegeName = "None";
  String address = 'placeholder_Address';
  List<String> urls = [];
  String desc = "desc";
  CollegePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      collegeName = (args as Map)['name'];
      urls = (args as Map)['urls'];
      desc = (args as Map)['desc'];
      address = (args as Map)['address'];
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleSpacing: 10,
          elevation: 0,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/location.png',
                  width: 38,
                  height: 38,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: <Widget>[
                TitleText(title: collegeName),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: TitleText(title: "Discussions"),
                ),
              ],
            ),
          ),
        ),
        // this will just show the college on the map
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[100],
          onPressed: () {
            Navigator.of(context).pushNamed(MapScreen.routeName, arguments: {
              "location": "myLocation",
              "potholes": {},
              'lat': "13.027967025983433",
              'lng': "77.56988895055157"
            });
          },
          tooltip: 'Chat With Us',
          child: const Icon(
            Icons.message_outlined,
            color: Color(0xff505050),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
