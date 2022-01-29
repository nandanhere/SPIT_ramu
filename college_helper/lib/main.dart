import 'package:college_helper/home/screens/chatPage.dart';
import 'package:college_helper/home/screens/collegePage.dart';
import 'package:college_helper/map_screen.dart';
import 'package:flutter/material.dart';

import 'home/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(
          title: "welcome",
        ),
        routes: {
          MapScreen.routeName: (ctx) => MapScreen(),
          ChatPage.routeName: (ctx) => ChatPage(),
        });
  }
}
