import 'package:college_helper/home/screens/chatPage.dart';
import 'package:college_helper/home/screens/collegePage.dart';
import 'package:college_helper/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<SharedPreferences> check_if_already_login() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    check_if_already_login();
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        SharedPreferences a = snapshot.data as SharedPreferences;
        bool val = a.getBool("dataThere") ?? false;
        a.clear();
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: val
                ? const MyHomePage(
                    title: "welcome",
                  )
                : ChatPage(),
            routes: {
              MapScreen.routeName: (ctx) => MapScreen(),
              ChatPage.routeName: (ctx) => ChatPage(),
            });
      },
    );
  }
}
