import 'package:college_helper/models/collegeDetails.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  static const routeName = "/chatPage";

  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollegeDetail deets = CollegeDetail(colleges: []);
  Future getCollegeDetails() async {
    final response = await http.get(Uri.parse(
        'https://fast-island-19739.herokuapp.com/api/college-details'));
    if (response.statusCode == 200) {
      return response.body;
    }
  }

  @override
  void initState() {
    super.initState();
    getCollegeDetails().then((value) {
      deets = collegeDetailFromJson(value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int h = DateTime.now().hour;
    double height = MediaQuery.of(context).size.height;
    int count = 0;
    String username = "";
    List<ChatMessage> messages = [
      ChatMessage(
          text: "Hello :) i am Drishti!", user: ChatUser(name: "Drishti")),
      if (username == "") ...[
        ChatMessage(text: "What is your name?", user: ChatUser(name: "Drishti"))
      ],
    ];
    quickReply(val) {
      print(val.value);
      messages.add(ChatMessage(text: val.value, user: ChatUser()));
      if (val.value == "no")
        messages.add(ChatMessage(text: "Oh", user: ChatUser(name: "Drishti")));
      else
        messages
            .add(ChatMessage(text: "wokay", user: ChatUser(name: "Drishti")));
    }

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
                  title: "😋 Yes",
                  value: "Yes",
                ),
                Reply(
                  title: "😞 Nope. What?",
                  value: "no",
                ),
              ],
            ),
          ));
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
      user: ChatUser(name: "AI"),
      onSend: onSend,
    );
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
  }
}
