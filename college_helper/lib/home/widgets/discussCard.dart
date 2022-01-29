import 'package:auto_size_text/auto_size_text.dart';
import 'package:college_helper/home/utils/color_gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class discussCard extends StatelessWidget {
  const discussCard({
    Key? key,
    required this.title,
    required this.name,
  }) : super(key: key);

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 160,
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: colorGetter(title)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            title,
            textAlign: TextAlign.start,
            minFontSize: 12,
            maxFontSize: 27,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: 27, color: Color(0xff363636))),
          ),
          AutoSizeText(
            name,
            textAlign: TextAlign.end,
            minFontSize: 12,
            maxFontSize: 20,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.raleway(
                textStyle: TextStyle(fontSize: 20, color: Color(0xff363636))),
          ),
        ],
      ),
    );
  }
}
