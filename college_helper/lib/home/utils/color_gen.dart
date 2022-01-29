import 'package:flutter/material.dart';

//https://api.flutter.dev/flutter/material/Colors/accents-constant.html

// Gets the color from a string
Color colorGetter(String title) {
  List cols = Colors.accents;
  // cols.remove(Colors.deepPurpleAccent);
  int total = 0;
  for (int i = 0; i < title.length; i++) {
    if (title[i] != ' ') {
      // ASCII * index
      total += title[i].codeUnitAt(0) * (i + 1);
    }
  }
  // .shade100 to make it lighter
  HSLColor val = HSLColor.fromColor(cols[total % cols.length].shade100);
  //made a slight variation - suraj, feel free to tweak
  return val.withLightness(0.93).withSaturation(0.8).toColor();
}
