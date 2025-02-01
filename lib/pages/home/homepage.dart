import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
// import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final dio = Dio();

  List history = [];
  List usedQuestionIdx = [];

  void returnText(String text) {
    if (history.isEmpty) {
      return;
    }
    setState(() {
      history[history.length - 1]['client'] = text;
    });
    setData();
  }

  void setData() async {
    Map result = await postHttp();
    print(result);
    setState(() {
      history = result["history"] ?? [];
      usedQuestionIdx = result["usedQuestionIdx"] ?? [];
    });
  }

  Future<Map> postHttp() async {
    try {
      print("history: $history");
      print("used idxs: $usedQuestionIdx");
      final response = await dio.post(
          "https://8e26-45-84-122-28.ngrok-free.app/respond",
          data: {"history": history, "used_question_idx": usedQuestionIdx});

      return {
        "history": jsonDecode(response.data)['history'],
        "usedQuestionIdx": jsonDecode(response.data)['used_question_idx'],
        "error": false,
      };
    } catch (e) {
      print('Error: $e');
      return {"history": null, "usedQuestionIdx": null, "error": e};
    }
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                itemCount: history.isEmpty ? 1 : history.length,
                itemBuilder: (context, index) {
                  if (history.isEmpty) {
                    return ChatBuble(text: "No history", isMe: true);
                  }

                  String bot = history[index]['bot']['Question_Text'] ?? "";
                  String client = history[index]['client'] ?? "";

                  List<Widget> toReturn = [];
                  if (bot.isNotEmpty) {
                    toReturn.add(ChatBuble(text: bot, isMe: false));
                  }
                  if (client.isNotEmpty) {
                    toReturn.add(ChatBuble(text: client, isMe: true));
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(children: toReturn),
                  );
                },
              ),
            ),
            TextInput(returnText: returnText)
          ],
        ),
      ),
    );
  }
}
