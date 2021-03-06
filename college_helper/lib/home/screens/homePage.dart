// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:college_helper/home/screens/chatPage.dart';
import 'package:college_helper/home/utils/color_gen.dart';
import 'package:college_helper/home/widgets/collegeCard.dart';
import 'package:college_helper/home/widgets/discussCard.dart';
import 'package:college_helper/home/widgets/titleText.dart';
import 'package:college_helper/map_screen.dart';
import 'package:college_helper/models/collegeDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

CollegeDetail deets = CollegeDetail(colleges: []);
// List<Location> locations = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> allDiscussions = [
    discussCard(
        name: "Jayant Sogikar",
        title: "How are we doing today?",
        url: "https://www.google.com/"),
    discussCard(
        name: "Jayant Sogikar",
        title: "What's the best college in Karantaka?",
        url: "https://www.google.com/"),
    discussCard(
        name: "Jayant Sogikar",
        title: "Omg, I failed every enterance test!",
        url: "https://www.google.com/"),
    discussCard(
        name: "Jayant Sogikar",
        title: "How to get into college without 12th?",
        url: "https://www.google.com/"),
  ];

  Future getCollegeDetails() async {
    final response = await http.get(Uri.parse(
        'https://fast-island-19739.herokuapp.com/api/college-details'));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  Future getDiscussions() async {
    final response = await http.get(Uri.parse(
        'https://www.reddit.com/r/Indian_Academia/top.json?limit=100&t=year'));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  // Future locGetter(loc) async {
  //   List await locationFromAddress("Gronausestraat 710, Enschede");
  // }

  @override
  void initState() {
    super.initState();
    getCollegeDetails().then((value) {
      var dict = {"colleges": []};
      dict['colleges']!.add(jsonDecode(value)['colleges'][0]);
      dict['colleges']!.add(jsonDecode(value)['colleges'][1]);
      dict['colleges']!.add(jsonDecode(value)['colleges'][2]);

      deets = collegeDetailFromJson(jsonEncode(dict));
      // deets = collegeDetailFromJson(value);

      setState(() {});
    });
    getDiscussions().then((value) {
      Map dict = jsonDecode(value);
      int ct = 0;
      List top = dict["data"]["children"];
      for (int i = 0; i < top.length; i++) {
        // for (int i = 0; i < 1; i++) {
        if (ct > 10) {
          break;
        }
        if (top[i]["data"]["title"].length <= 50 &&
            top[i]["data"]["over_18"] == false) {
          ct += 1;
          allDiscussions.add(discussCard(
            title: top[i]["data"]["title"],
            name: top[i]["data"]["author"],
            url: top[i]["data"]["url"],
          ));
        }
      }
      setState(() {});
      // print(dict["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int h = DateTime.now().hour;
    double height = MediaQuery.of(context).size.height;
    List<Widget> collegeCards = [
      // CollegeCard(
      //   i: 0,
      //   width: width,
      //   title: "Ramaiah Institute Of Technology",
      //   address: "MSR Nagar, Bangalore",
      //   imgUrl:
      //       'https://upload.wikimedia.org/wikipedia/en/5/5a/Ramaiah_Institutions_Logo.png',
      // ),
      // CollegeCard(
      //   i: 1,
      //   width: width,
      //   title: "RV College Of Engineering",
      //   address: "RR Nagar, Bangalore",
      //   imgUrl:
      //       'https://upload.wikimedia.org/wikipedia/en/5/5a/Ramaiah_Institutions_Logo.png',
      // ),
    ];
    int ct = 0;
    // for (int i = 0; i < deets.colleges.length; i++) {
    // print(deets.colleges[0]);
    for (int i = 0; i < min(deets.colleges.length, 3); i++) {
      collegeCards.add(CollegeCard(
          i: ct,
          width: width,
          title: deets.colleges[i].college.name,
          address: deets.colleges[i].address,
          imgUrl: deets.colleges[i].imageUrls[0]));
      ct += 1;
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
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  Navigator.of(context)
                      .pushNamed(MapScreen.routeName, arguments: {
                    "deets": deets,
                    "location": "myLocation",
                    "colleges": [],
                    'lat': position.latitude.toString(),
                    'lng': position.longitude.toString()
                  });
                },
                icon: Image.asset(
                  'assets/images/location.png',
                  width: 38,
                  height: 38,
                ),
              ),
            )
          ],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Text(
                (h > 6 && h < 12)
                    ? "Good Morning!"
                    : (h <= 17)
                        ? "Good Afternoon!"
                        : "Good Evening!",
                // style: TextStyle(fontSize: 35, color: Color(0xff595959)),
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 30, color: Color(0xff060606))),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: <Widget>[
                TitleText(title: "Colleges Nearby"),
                const SizedBox(
                  height: 15,
                ),
                ...collegeCards,
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    child: Text(
                      "Find More",
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 16, color: Color(0xff565656))),
                    ),
                    onPressed: () async {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      Navigator.of(context)
                          .pushNamed(MapScreen.routeName, arguments: {
                        "deets": deets,
                        "location": "myLocation",
                        "colleges": [],
                        'lat': position.latitude.toString(),
                        'lng': position.longitude.toString()
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue[100]!),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side:
                                        BorderSide(color: Colors.red[200]!)))),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TitleText(title: "Discussions"),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: allDiscussions,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[100],
          onPressed: () {
            Navigator.of(context).pushNamed(
              ChatPage.routeName,
            );
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
