import 'dart:async';

import 'package:college_helper/home/screens/homePage.dart';
import 'package:college_helper/models/collegeDetails.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  static const routeName = "/chatPage";
  List<ChatMessage> messages = [];

  ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int h = DateTime.now().hour;
    double height = MediaQuery.of(context).size.height;
    int count = 0;
    String username = "";
    int expenditure = 9999999;
    int from = -1;
    int to = -1;
    late SharedPreferences data;
    List<String> subjects = [];
    List<ChatMessage> messages = [
      ChatMessage(
          text: "Hello :) i am Drishti!", user: ChatUser(name: "Drishti")),
      if (username == "") ...[
        ChatMessage(text: "What is your name?", user: ChatUser(name: "Drishti"))
      ],
    ];
    goToHome() {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return const MyHomePage(
          title: "Here are your Results",
        );
      }));
    }

    savePrefs() async {
      data.setBool("dataThere", true);
      data.setInt('from', from);
      data.setInt('to', to);
      data.setInt('expenditure', expenditure);
      data.setString("username", username);
      data.setStringList("subjects", subjects);
    }

    quickReply(val) {
      messages.add(ChatMessage(text: val.value, user: ChatUser()));
      if (val.value == "no") {
        messages
            .add(ChatMessage(text: "Okay! ", user: ChatUser(name: "Drishti")));
      }
      if (val.value == "EE" || val.value == "ME" || val.value == "CS") {
        if (val.value == "EE") subjects.add("Electronic");
        if (val.value == "ME") {
          subjects.add("Mechanic");
          subjects.add("Civil");
        }
        if (val.value == "CS") {
          subjects.add("Computer");
          subjects.add("Information");
        }
        messages.add(
            ChatMessage(text: "Got it! ", user: ChatUser(name: "Drishti")));
      }
      if (val.value == "rich") {
        messages.add(ChatMessage(
            text: "We'll now show you your results",
            user: ChatUser(name: "Drishti")));
        savePrefs();
        Timer(Duration(seconds: 3), () {
          goToHome();
        });
      }
    }

// TODO: check here if previous data is available
// if data is there :
    // count = 1

    onSend(ChatMessage chatmessage) {
      messages.add(chatmessage);
      switch (count) {
        case 0:
          String s = chatmessage.text ?? "Student";
          username = s;
          messages.add(ChatMessage(
              text: "I see you are searching for colleges, " + s,
              user: ChatUser(name: "Drishti")));
          messages.add(ChatMessage(
            text: "do you have a particular cutoff you are searching for ?",
            user: ChatUser(name: "Drishti"),
            quickReplies: QuickReplies(
              values: <Reply>[
                Reply(
                  title: "No, i Dont",
                  value: "no",
                ),
              ],
            ),
          ));
          break;
        case 1:
          String text = chatmessage.text ?? '1000';
          List<String> arr = text.split(' ');
          for (int i = 0; i < arr.length; i++) {
            String tt = arr[i];
            tt.replaceAll(RegExp(r'[^0-9]'), '');
            arr[i] = tt;
            if (from == -1 && int.tryParse(tt) != null) {
              from = int.parse(tt);
            } else if (to == -1 && int.tryParse(tt) != null) {
              to = int.parse(tt);
            }
          }
          messages.add(ChatMessage(
            text: "Got it. Do you have any preferences in branches ?",
            user: ChatUser(name: "Drishti"),
            quickReplies: QuickReplies(
              values: <Reply>[
                Reply(
                  title: "Electronics",
                  value: "EE",
                ),
                Reply(
                  title: "Mechanical",
                  value: "ME",
                ),
                Reply(
                  title: "Computers",
                  value: "CS",
                ),
                Reply(
                  title: "No, i Dont",
                  value: "no",
                ),
              ],
            ),
          ));
          break;
        case 2:
          String query = chatmessage.text ?? "ALL";
          if (query.contains("EE") || query.contains("Electronic")) {
            subjects.add("Electronic");
          }
          if (query.contains("ME") || query.contains("Mechanic")) {
            subjects.add("Mechanic");
            subjects.add("Civil");
          }
          if (query.contains("CS") || query.contains("Mechanic")) {
            subjects.add("Computer");
            subjects.add("Information");
          }
          messages
              .add(ChatMessage(text: "Nice!", user: ChatUser(name: "Drishti")));
          messages.add(ChatMessage(
            text: "Now, do you have any upper limit to your expenditure?",
            user: ChatUser(name: "Drishti"),
            quickReplies: QuickReplies(
              values: <Reply>[
                Reply(
                  title: "Not really",
                  value: "rich",
                ),
              ],
            ),
          ));
          break;

        case 3:
          String text = chatmessage.text ?? '10000000';
          text.replaceAll(RegExp(r'[\w]'), "");
          if (int.tryParse(text) != null) expenditure = int.parse(text);
          print([username, expenditure, from, to, subjects]);
          messages.add(ChatMessage(
              text: "We'll now show you your results",
              user: ChatUser(name: "Drishti")));
          savePrefs();

          Timer(Duration(seconds: 3), () {
            goToHome();
          });
          break;
        default:
          messages.add(ChatMessage(
              text: "Sorry :( i have not been programmed to answer that..",
              user: ChatUser(name: "Drishti")));
      }
      count += 1;
    }

    DashChat currentChat = DashChat(
      onQuickReply: quickReply,
      messages: messages,
      user: ChatUser(),
      onSend: onSend,
    );
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        }
        data = snapshot.data as SharedPreferences;

        if (data.getBool("dataThere") ?? false) {
          username = data.getString("username") ?? "";
          messages = [
            ChatMessage(
              text:
                  "${username} ,do you have a particular cutoff you are searching for ?",
              user: ChatUser(name: "Drishti"),
            )
          ];
        }
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
                      (h > 6 && h < 12)
                          ? "Good Morning!"
                          : (h <= 17)
                              ? "Good Afternoon!"
                              : "Good Evening!",
                      // style: TextStyle(fontSize: 35, color: Color(0xff595959)),
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              fontSize: 30, color: Color(0xff060606))),
                    )
                  ],
                ),
              ),
              body:
                  currentChat // This trailing comma makes auto-formatting nicer for build methods.
              ),
        );
      },
    );
  }
}
