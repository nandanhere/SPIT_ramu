import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:college_helper/home/utils/color_gen.dart';
import 'package:college_helper/home/widgets/titleText.dart';
import 'package:college_helper/map_screen.dart';
import 'package:college_helper/models/collegeDetails.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      width: width,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Column(
            children: <Widget>[
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
          )),
    );
  }
}

class CollegePage extends StatefulWidget {
  final CollegeElement clg;
  CollegePage({Key? key, required this.clg}) : super(key: key);

  @override
  State<CollegePage> createState() => _CollegePageState();
}

class _CollegePageState extends State<CollegePage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    String url = widget.clg.college.website;
    void _launchURL() async {
      if (!await launch(url)) throw 'Could not launch $url';
    }

    List<Widget> imageSliders() {
      List arr = widget.clg.imageUrls;
      List<Widget> fin = [];
      for (int i = 1; i < arr.length; i++) {
        fin.add(CarouselItem(imageUrl: arr[i]));
      }
      return fin;
    }

    List<Widget> getBranches() {
      List<Widget> arr = [];
      List ref = widget.clg.branches;
      for (int i = 0; i < ref.length; i++) {
        print(ref[i].toString());
        arr.add(Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: colorGetter(ref[i].branch),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            ref[i].branch.toString().toUpperCase(),
            style: GoogleFonts.raleway(fontSize: 11),
          ),
        ));
      }
      return arr;
    }

    final CarouselController _controller = CarouselController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
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
                    "deets": CollegeDetail(colleges: [widget.clg]),
                    "location": "myLocation",
                    "colleges": [],
                    'lat': widget.clg.coordinates[0].toString(),
                    'lng': widget.clg.coordinates[1].toString(),
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
          title: Text(
            "Know The College",
            // style: TextStyle(fontSize: 35, color: Color(0xff595959)),
            textAlign: TextAlign.start,
            style: GoogleFonts.raleway(
                textStyle:
                    const TextStyle(fontSize: 30, color: Color(0xff060606))),
          ),
        ),
        body: SingleChildScrollView(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          // child: Container(),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(top: 5.0),
                //   child: TitleText(title: "Discussions"),
                // ),
                CarouselSlider(
                  items: imageSliders(),
                  carouselController: _controller,
                  options: CarouselOptions(
                      viewportFraction: 0.95,
                      autoPlay: true,
                      enlargeCenterPage: false,
                      aspectRatio: 2,
                      autoPlayInterval: const Duration(seconds: 5),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AutoSizeText(
                    widget.clg.college.name,
                    minFontSize: 14,
                    maxFontSize: 28,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            fontSize: 28, color: Color(0xff060606))),
                  ),
                ),
                Subtitle(
                  text: widget.clg.address,
                  maxLim: 28,
                  imgUrl:
                      "https://image.flaticon.com/icons/png/512/1257/1257364.png",
                  i: 0,
                ),
                Subtitle(
                  text: "Average Fee \n" + widget.clg.collegeFees.toString(),
                  maxLim: 20,
                  imgUrl:
                      "https://image.flaticon.com/icons/png/512/1247/1247153.png",
                  i: 1,
                ),
                Subtitle(
                    text: "Hostel Fee \n" + widget.clg.hostelFees.toString(),
                    maxLim: 20,
                    imgUrl:
                        "https://image.flaticon.com/icons/png/512/1247/1247236.png",
                    i: 0),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Row(
                    children: [
                      AutoSizeText(
                        "Branches",
                        minFontSize: 14,
                        maxFontSize: 28,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                                fontSize: 28, color: Color(0xff060606))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      Wrap(spacing: 5, runSpacing: 5, children: getBranches()),
                ),
                ElevatedButton(
                  onPressed: () {
                    _launchURL();
                  },
                  child: Text(
                    "Know More",
                    style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            fontSize: 16, color: Color(0xff565656))),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[100]!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red[200]!)))),
                ),
              ],
            ),
          ),
        ),
        // this will just show the college on the map
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.deepOrange[100],
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(MapScreen.routeName, arguments: {
        //       "location": "myLocation",
        //       "potholes": {},
        //       'lat': "13.027967025983433",
        //       'lng': "77.56988895055157"
        //     });
        //   },
        //   tooltip: 'Chat With Us',
        //   child: const Icon(
        //     Icons.message_outlined,
        //     color: Color(0xff505050),
        //   ),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle(
      {Key? key,
      required this.text,
      required this.maxLim,
      required this.imgUrl,
      required this.i})
      : super(key: key);
  final String text;
  final double maxLim;
  final String imgUrl;
  final int i;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: (i == 0)
          ? Row(
              children: [
                CachedNetworkImage(
                  imageUrl: imgUrl,
                  width: 70,
                  height: 70,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: w / 2 - 10,
                  child: AutoSizeText(text,
                      textAlign: TextAlign.left,
                      minFontSize: 14,
                      maxFontSize: maxLim,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 28, color: Color(0xff060606)))),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: w / 2 - 10,
                  child: AutoSizeText(text,
                      textAlign: TextAlign.right,
                      minFontSize: 14,
                      maxFontSize: maxLim,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 28, color: Color(0xff060606)))),
                ),
                CachedNetworkImage(
                  imageUrl: imgUrl,
                  width: 70,
                  height: 70,
                ),
              ],
            ),
    );
  }
}

// class shf extends StatelessWidget {
//   static const routeName = "/collegePage";

//   // String collegeName = "None";
//   // String address = 'placeholder_Address';
//   // List<String> urls = [];
//   // String desc = "desc";
//   CollegePage({Key? key, required this.clg}) : super(key: key);
//   final CollegeElement clg;
//   int _current = 0;
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> imageSliders() {
//       return clg.imageUrls.map((a) => CarouselItem(imageUrl: a)).toList();
//     }

//     final CarouselController _controller = CarouselController();
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           leadingWidth: 0,
//           titleSpacing: 10,
//           elevation: 0,
//           centerTitle: false,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: IconButton(
//                 onPressed: () {},
//                 icon: Image.asset(
//                   'assets/images/location.png',
//                   width: 38,
//                   height: 38,
//                 ),
//               ),
//             )
//           ],
//           title: Text(
//             "Know The College",
//             // style: TextStyle(fontSize: 35, color: Color(0xff595959)),
//             textAlign: TextAlign.start,
//             style: GoogleFonts.raleway(
//                 textStyle:
//                     const TextStyle(fontSize: 30, color: Color(0xff060606))),
//           ),
//         ),
//         body: SingleChildScrollView(
//           // Center is a layout widget. It takes a single child and positions it
//           // in the middle of the parent.
//           // child: Container(),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 15.0),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0, right: 8),
//                   child: AutoSizeText(
//                     clg.college.name,
//                     minFontSize: 14,
//                     maxFontSize: 28,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.raleway(
//                         textStyle: const TextStyle(
//                             fontSize: 28, color: Color(0xff060606))),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 // const Padding(
//                 //   padding: EdgeInsets.only(top: 5.0),
//                 //   child: TitleText(title: "Discussions"),
//                 // ),
//                 CarouselSlider(
//                   items: imageSliders(),
//                   carouselController: _controller,
//                   options: CarouselOptions(
//                       viewportFraction: 0.95,
//                       autoPlay: true,
//                       enlargeCenterPage: false,
//                       aspectRatio: 2,
//                       autoPlayInterval: const Duration(seconds: 5),
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           _current = index;
//                         });
//                       }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // this will just show the college on the map
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.deepOrange[100],
//           onPressed: () {
//             Navigator.of(context).pushNamed(MapScreen.routeName, arguments: {
//               "location": "myLocation",
//               "potholes": {},
//               'lat': "13.027967025983433",
//               'lng': "77.56988895055157"
//             });
//           },
//           tooltip: 'Chat With Us',
//           child: const Icon(
//             Icons.message_outlined,
//             color: Color(0xff505050),
//           ),
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }
// }
