import 'package:auto_size_text/auto_size_text.dart';
import 'package:college_helper/home/utils/color_gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: CircularProgressIndicator(),
              ),
              width: width / 2 - 20,
              height: 150,
              fit: BoxFit.fitHeight,
            ),
            // child: Image.network(
            //   imgUrl,
            // width: width / 2 - 20,
            // height: 150,
            // fit: BoxFit.fitHeight,
            // ),
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
