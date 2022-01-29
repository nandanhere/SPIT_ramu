import 'package:auto_size_text/auto_size_text.dart';
import 'package:college_helper/home/utils/color_gen.dart';
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
            padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Colleges Nearby',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 40, color: Color(0xff060606))),
                    ),
                  ],
                ),
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
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange[100],
          onPressed: () {},
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

class CollegeCard extends StatelessWidget {
  const CollegeCard({
    Key? key,
    required this.width,
    required this.title,
    required this.address,
    required this.imgUrl,
  }) : super(key: key);

  final double width;
  final String title;
  final String address;
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: width - 20,
      height: 150,
      decoration: BoxDecoration(
          color: colorGetter(title),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.network(
              imgUrl,
              width: width / 2 - 20,
              height: 150,
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.only(right: 10.0),
                width: width / 2 - 40,
                child: AutoSizeText(
                  title,
                  textAlign: TextAlign.end,
                  minFontSize: 12,
                  maxFontSize: 33,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                          fontSize: 33, color: Color(0xff565656))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                color: Colors.black54,
                alignment: Alignment.centerRight,
                height: 2,
                width: width / 4,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.only(right: 10.0),
                width: width / 2 - 40,
                child: AutoSizeText(
                  address,
                  textAlign: TextAlign.end,
                  minFontSize: 11,
                  maxFontSize: 16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                          fontSize: 33, color: Color(0xff565656))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
