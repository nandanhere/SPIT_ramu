import 'package:auto_size_text/auto_size_text.dart';
import 'package:college_helper/home/utils/color_gen.dart';
import 'package:college_helper/home/widgets/collegeCard.dart';
import 'package:college_helper/home/widgets/discussCard.dart';
import 'package:college_helper/home/widgets/titleText.dart';
import 'package:college_helper/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String name = "Jayant Sogikar";
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Text(
                "Good Morning!",
                // style: TextStyle(fontSize: 35, color: Color(0xff595959)),
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 30, color: Color(0xff060606))),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: <Widget>[
                TitleText(title: "Colleges Nearby"),
                const SizedBox(
                  height: 15,
                ),
                CollegeCard(
                  width: width,
                  title: "Ramaiah Institute Of Technology",
                  address: "MSR Nagar, Bangalore",
                  imgUrl:
                      'https://www.iesonline.co.in/colleges-image/ramaiah-institute-of-technology.jpg',
                ),
                CollegeCard(
                  width: width,
                  title: "RV College Of Engineering",
                  address: "RR Nagar, Bangalore",
                  imgUrl:
                      'https://www.iesonline.co.in/colleges-image/ramaiah-institute-of-technology.jpg',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    child: Text(
                      "Find More",
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 16, color: Color(0xff565656))),
                    ),
                    onPressed: () {},
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
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TitleText(title: "Discussions"),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      discussCard(
                        name: name,
                        title: "How are we doing today?",
                      ),
                      discussCard(
                        name: name,
                        title: "What's the best college in Karantaka?",
                      ),
                      discussCard(
                        name: name,
                        title: "Omg, I failed every enterance test!",
                      ),
                      discussCard(
                        name: name,
                        title: "How to get into college without 12th?",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[100],
          onPressed: () {
            Map<String, Map<String, String>> potholes = {
              "MSRIT": {"id": "Ramaiah", "lat": "13.038293", "lng": "77.566676"}
            };
            Navigator.of(context).pushNamed(MapScreen.routeName, arguments: {
              "location": "myLocation",
              "potholes": potholes,
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
