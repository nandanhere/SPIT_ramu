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
                  children: [
                    Text(
                      'Colleges Nearby',
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 40, color: Color(0xff060606))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: width - 20,
                  height: 150,
                  decoration: BoxDecoration(
                      color: colorGetter("RIT"),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Image.network(
                          'https://www.iesonline.co.in/colleges-image/ramaiah-institute-of-technology.jpg',
                          width: width / 2 - 20,
                          height: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            Container(
                              width: width / 2 - 40,
                              child: AutoSizeText(
                                "Ramaiah Institute Of Technology",
                                textAlign: TextAlign.end,
                                minFontSize: 15,
                                maxFontSize: 33,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                        fontSize: 33,
                                        color: Color(0xff565656))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
