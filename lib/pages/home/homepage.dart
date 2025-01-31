import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
import 'package:http/http.dart' as http;

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
    //postHttp();
  }

  void postHttp() async {
    try {
      final response = await dio.post(
          "https://b875-45-84-122-8.ngrok-free.app/respond",
          data: {"history": history, "used_question_idx": usedQuestionIdx});

      setState(() {
        history = jsonDecode(response.data)['history'];
        usedQuestionIdx = jsonDecode(response.data)['used_question_idx'];
      });
      print(jsonDecode(response.data));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    postHttp();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
                children: history.isEmpty
                    ? [ChatBuble(text: "No history", isMe: true)]
                    : history.map<Widget>((e) {
                        String? bot = e['bot']['Question_Text'];
                        String? client = e['client'];
                        List<Widget> toReturn = [];
                        if (bot != null) {
                          toReturn.add(
                            ChatBuble(
                              text: bot ?? "",
                              isMe: false,
                            ),
                          );
                        }
                        if (client != null) {
                          toReturn.add(
                            ChatBuble(
                              text: client ?? "",
                              isMe: true,
                            ),
                          );
                        }
                        return Column(
                            children:
                                toReturn.isEmpty ? [Text("error")] : toReturn);
                      }).toList()),
          ),
          TextInput(returnText: returnText)
        ],
      ),
    );
  }
}
