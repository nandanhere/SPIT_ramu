import 'package:flutter/material.dart';

//https://api.flutter.dev/flutter/material/Colors/accents-constant.html
const cols = Colors.accents;

// Gets the color from a string
Color colorGetter(String title) {
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
  return val.withLightness(0.91).withSaturation(0.8).toColor();
}
